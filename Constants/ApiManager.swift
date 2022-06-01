
 import UIKit
 import Alamofire
 import SwiftyJSON
 
 class ApiManager: NSObject {
    
    static let sharedInstance = ApiManager.init()
    
    func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default , headers: nil).responseJSON { (responseObject) -> Void in
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
   
    
    
     func requestGetURL(_ strURL: String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
        Alamofire.request(strURL).responseJSON { (responseObject) -> Void in
            
            print(responseObject)
            
            if responseObject.result.isSuccess {
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    func requestMultiPartURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]? , imagesArray : [UIImage], imageName: [String],  success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            if imagesArray.count != 0 {
                
                for i in 0..<imagesArray.count{
                    
                    multipartFormData.append(UIImageJPEGRepresentation(imagesArray[i], 0.3)!, withName: imageName[i], fileName: "swift_file\(i).jpeg", mimeType: "image/jpg")
                }
            }
            
            for (key, value ) in params! {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, usingThreshold:UInt64.init(),
           to: strURL,
           method: .post,
           headers:headers,
           encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _ ,_ ):
                
                upload.uploadProgress(closure: { (progress) in
                    UILabel().text = "\((progress.fractionCompleted * 100)) %"
                    print (progress.fractionCompleted * 100)
                })
                
                
                
                upload.responseJSON { response in
                    
                    guard ((response.result.value) != nil) else{
                        failure(response.result.error!)
                        return
                    }
                    
                    let resJson = JSON(response.result.value!)
                    success(resJson)
                    
                }
                
            case .failure(let encodingError):
                failure(encodingError.localizedDescription as! Error)
                
            }
            
        })
    }
    

    
 }
