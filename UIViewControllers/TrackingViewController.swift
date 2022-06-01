
import UIKit
import GoogleMaps
import GooglePlaces

typealias ServiceResponse = (Data?,URLResponse?, Error?) ->Void



class TrackingViewController: UIViewController ,GMSMapViewDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UIPickerViewDelegate{

    var videoPath: NSURL? = nil

    //MARK: OUTLETS
    
    var childID = String()
    @IBOutlet weak var mapView: GMSMapView!
    
    //MARK: VARIABLES
        var pinPoint = GMSMarker()
    
    
      var childLats = Double()
        var childLongs =  Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.delegate = self
        self.mapView.animate(toZoom: 10)
        
        let coordinates = CLLocationCoordinate2D(latitude: Double(self.childLats) , longitude: Double(self.childLongs))
        self.pinPoint.position = coordinates
        self.pinPoint.map = self.mapView
        self.mapView.animate(toLocation: coordinates)
        self.mapView.animate(toZoom: 14)
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addVideoTapped(_ sender: Any) {
        
           self.showActionSheet(title: "Upload a video from")
    }
    
    
    
    func photoFromLibrary(){
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        picker.popoverPresentationController?.sourceView = self.view
        
    }
    func photoFromCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let picker = UIImagePickerController()
            picker.allowsEditing = false
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            self.showAlert(messageStr: "Sorry, this device has no camera")
        }
        
    }
    
    func showActionSheet(title : String){
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        let takePhoto = UIAlertAction(title: "Camera", style: .default) { (action) in
            self.photoFromCamera()
        }
        alertController.addAction(takePhoto)
        
        let selectPhoto = UIAlertAction(title: "Gallery", style: .default) { (action) in
            self.photoFromLibrary()
        }
        alertController.addAction(selectPhoto)
        
        
        alertController.popoverPresentationController?.sourceView = self.view
        self.present(alertController, animated: true) {
            
        }
    }
    //MARK: - Image PickerView Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
    
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
            
            if mediaType == "public.movie" {
                print("Video Selected")
                let videoURL = info[UIImagePickerControllerMediaURL] as? NSURL
                self.videoPath = videoURL
                let param  = ["parent_id" : standard.value(forKey: "user_id")!,"child_id":childID]
                
                self.callAPIForUploadVideo(params: param as [String : AnyObject])
            }
        }
        
        dismiss(animated:true, completion: nil)
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    

    
    func callAPIForUploadVideo( params : [String : AnyObject]?){
         self.view.startIndicator()
        
        let apiURL = baseUrl + "add_video"
        
             Alamofire.upload(multipartFormData: { (multipartFormData) in
                
                let val = arc4random_uniform(100)

                multipartFormData.append((self.videoPath?.filePathURL)!, withName: "video", fileName: "filename\(val).mp4", mimeType: "video/mp4")
            
            for (key, value ) in params! {
                
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)

            }
            
        }, to: apiURL)
        { (result) in
            switch result {
            case .success(let upload, _ , _):
                
                
                upload.uploadProgress(closure: { (progress) in
                    print (progress.fractionCompleted * 100)
                })
                
                upload.responseJSON { response in
                    self.view.stopIndicator()
                    
                    guard ((response.result.value) != nil) else{
                        print(response.result.error!)
                        return
                    }
                    
                    let resJson = JSON(response.result.value!)
                    print(resJson)
                    
                }
                
            case .failure(let encodingError):
                print("failed")
                 self.view.stopIndicator()
                print(encodingError)
                self.showAlert(messageStr: "Failed to Upload Video")
                
            }
        }
    }

    
    func api(params: Parameters, videoData: NSData){
    
        let imageData = videoData
        
        // CREATE AND SEND REQUEST ----------
        
        let urlRequest = urlRequestWithComponents(urlString: (baseUrl + "add_video"), parameters: params as! Dictionary<String, String>, imageData: imageData)
        
        
        
        
//        Alamofire.upload(urlRequest.0, urlRequest.1).progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
//                print("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
//            }
//            .responseJSON { (request, response, JSON, error) in
//                println("REQUEST \(request)")
//                println("RESPONSE \(response)")
//                println("JSON \(JSON)")
//                println("ERROR \(error)")
//        }
//
        
    }
    
    func urlRequestWithComponents(urlString:String, parameters:Dictionary<String, String>, imageData:NSData) -> (URLRequestConvertible, NSData) {
        
        // create url request to send
        var mutableURLRequest = NSMutableURLRequest(url: NSURL(string: urlString)! as URL)
        mutableURLRequest.httpMethod = Alamofire.HTTPMethod.post.rawValue
        let boundaryConstant = "myRandomBoundary12345";
        let contentType = "multipart/form-data;boundary="+boundaryConstant
        mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add image
        uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append("Content-Disposition: form-data; name=\"file\"; filename=\"file.png\"\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
        uploadData.append(imageData as Data)
        
        // add parameters
        for (key, value) in parameters {
            uploadData.append("\r\n--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n\(value)".data(using: String.Encoding.utf8)!)
        }
        uploadData.append("\r\n--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        
        // return URLRequestConvertible and NSData
        let rqst = Alamofire.request(baseUrl + "add_video", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil)
        
        return (rqst as! URLRequestConvertible, uploadData)
    }
    
}
