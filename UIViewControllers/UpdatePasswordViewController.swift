
import UIKit

class UpdatePasswordViewController: ViewController {

    @IBOutlet weak var txtConfirmNewPassword: AETextFieldValidator!
    @IBOutlet weak var txtNewPasword: AETextFieldValidator!
    
    var userID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNewPasword.addRegx(passwordReg, withMsg: invalidPassword)
         txtConfirmNewPassword.addRegx(passwordReg, withMsg: invalidPassword)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        
        if txtNewPasword.validate() == true && txtConfirmNewPassword.validate() == true {
            
            let params : Parameters = ["user_id":self.userID,"password":self.txtNewPasword.text!]
            self.updatePassApiCall(parameters: params)
          
        }
        
        
  
        
    }
  
    //MARK:- Api Call Function
    
    func updatePassApiCall(parameters: Parameters){
        AccountApiInterface.sharedInstance.postRequestWithParam(fromViewController: self, actionName: "change_password", dictParam: parameters as [String : AnyObject], success: { (json) in
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            standard.setValue(self.userID, forKey: "user_id")
            standard.setValue(json["data"]["email"].stringValue, forKey: "email")
            standard.setValue(json["data"]["first_name"].stringValue, forKey: "first_name")
            standard.setValue(json["data"]["last_name"].stringValue, forKey: "last_name")
            standard.setValue(json["data"]["image"].stringValue, forKey: "image")
            self.navigationController?.pushViewController(vc, animated: true)
            
        }) { (error) in
            self.showAlert(messageStr: error)
        }
        
    }
}
