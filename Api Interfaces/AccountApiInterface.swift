
import UIKit

class AccountApiInterface: NSObject {

    static let sharedInstance = AccountApiInterface()
    
    func postRequestWithParam(fromViewController: UIViewController,actionName : String , dictParam : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void){
       
        print(dictParam ?? [String : AnyObject]())
        fromViewController.view.startIndicator()
        ApiManager.sharedInstance.requestPOSTURL(baseUrl + actionName, params: dictParam , headers: nil, success: { (result) in
           fromViewController.view.stopIndicator()
            print(result)
            guard ((result["status"].intValue) != 0) else{
                
                print(result["msg"].stringValue)
                
                failure(result["msg"].stringValue)
                return
            }
          
            success(result)
            
       
        }) { (error) in
              fromViewController.view.stopIndicator()
            
            print(error.localizedDescription)
            failure(error.localizedDescription)
        }
        
    }

    func getRequestWithParam(fromViewController: UIViewController,actionName : String , success:@escaping (JSON) -> Void, failure:@escaping (String) -> Void){
        
           fromViewController.view.startIndicator()
         print(baseUrl + actionName)
        
       
        ApiManager.sharedInstance.requestGetURL(baseUrl + actionName, success: { (result) in
            print(result)
            fromViewController.view.stopIndicator()
            guard ((result["status"].intValue) != 0) else{
                
                print(result["msg"].stringValue)
                
                failure(result["msg"].stringValue)
                return
            }
            
            success(result)
        }) { (error) in
              fromViewController.view.stopIndicator()
            print(error.localizedDescription)
            failure(error.localizedDescription)
        }
        
        
    }
    
    

}
