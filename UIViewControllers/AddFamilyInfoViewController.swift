
import UIKit

class AddFamilyInfoViewController: ViewController ,UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource{

    
     let pickerArr = ["Father","Mother"]
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    
    
    var imageParent = UIImage()
    var imageParentChanged = false
    var imageChildChanged = false
     var imageChild = UIImage()
    
    var isParentImage = Bool()
    override func viewDidLoad() {
        super.viewDidLoad()
  tableView.tableFooterView = UIView()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func hitOkunction(sender : UIButton){
        
        
        if self.imageParentChanged == false || self.imageChildChanged == false{
            self.showAlert(messageStr: "Please Inset Parent and Child's Image")
            
        } else{
        
        let cell = self.tableView.cellForRow(at: [0,0]) as! FamilyInfoTableViewCell
        let cell2 = self.tableView.cellForRow(at: [0,1]) as! FamilyInfoTableViewCell
        
        let params : Parameters = ["first_name":cell.txtParentFirstname.text!, "last_name":cell.txtParentLastName.text!, "parent_id":standard.value(forKey: "user_id") ?? "", "relationship":cell.txtRelation.text!, "child_first_name":cell2.txtChildFirstName.text!, "child_last_name":cell2.txtChildLastName.text!, "birth":cell2.txtBirthday.text!, "username":cell2.txtUserName.text!,"password":cell2.txtPassword.text!]
        
        let imgs = [imageParent,imageChild]
        self.addChildApiCall(parameters: params, imgArray: imgs, imgNameArray: ["parent_pic","child_pic"])
        }
    }
    
    
    @objc func addImagefunction(sender : UIButton){
        
        
        if sender.tag == 0 {
            isParentImage = true
            
        }
        else{
            isParentImage = false
        }
        self.showActionSheet(title: "Upload a photo from")
    }
    @objc  func dateChange(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
          let cell = tableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! FamilyInfoTableViewCell
        
       cell.txtBirthday.text = formatter.string(from: sender.date)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellParent", for: indexPath) as! FamilyInfoTableViewCell
            
            cell.btnUpload1.setImage(imageParent, for: .normal)
            
            cell.btnUpload1.tag = 0
            let picker = UIPickerView()
            picker.dataSource = self
            picker.delegate = self
            cell.txtRelation.inputView = picker
            cell.btnUpload1.addTarget(self, action: #selector(self.addImagefunction(sender:)), for: .touchUpInside)
            return cell
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellChild", for: indexPath) as! FamilyInfoTableViewCell
            

            cell.btnUpload2.setImage(imageChild, for: .normal)
            
            cell.btnUpload2.tag = 1
            cell.btnUpload2.addTarget(self, action: #selector(self.addImagefunction(sender:)), for: .touchUpInside)
              cell.btnHitOk.addTarget(self, action: #selector(self.hitOkunction(sender:)), for: .touchUpInside)
             let datePicker = UIDatePicker()
            datePicker.addTarget(self, action: #selector(self.dateChange(sender:)), for: .valueChanged)
            
            datePicker.datePickerMode = .date
            cell.txtBirthday.inputView = datePicker
            
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 0 {
            return 170
        }
         else{
            return 285
        }
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
        
        let selectPhoto = UIAlertAction(title: "Photo Gallery", style: .default) { (action) in
            self.photoFromLibrary()
        }
        alertController.addAction(selectPhoto)
        
        
        alertController.popoverPresentationController?.sourceView = self.view
        self.present(alertController, animated: true) {
            
        }
    }
    //MARK: - Image PickerView Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(img)
    
        
        if isParentImage == true {
            imageParent = img
            self.imageParentChanged = true
        }
        else{
            imageChild = img
            self.imageChildChanged = true
        }
        self.tableView.reloadData()
        
        
        dismiss(animated:true, completion: nil)
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
    
    //MARK:- PickerView Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
      let cell = self.tableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? FamilyInfoTableViewCell
        
        cell?.txtRelation.text = pickerArr[row]
        
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArr[row]
    }
    
    
    
    //MARK:- Api Call Function
    
    func addChildApiCall(parameters: Parameters,imgArray: [UIImage],imgNameArray: [String]){
        
        let url = baseUrl + "family_info"
        self.view.startIndicator()
        ApiManager.sharedInstance.requestMultiPartURL(url, params: parameters as [String : AnyObject], headers: nil, imagesArray: imgArray, imageName: imgNameArray, success: { (json) in
        
            self.view.stopIndicator()
            self.showAlert(messageStr: json["msg"].stringValue)
            self.navigationController?.popViewController(animated: true)
            
        }) { (error) in
            self.view.stopIndicator()
            self.showAlert(messageStr: error.localizedDescription)
        }
        
        
    }
    
    
    
}
