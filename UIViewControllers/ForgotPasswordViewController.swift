

import UIKit

class ForgotPasswordViewController: ViewController {

    @IBOutlet weak var txtEmail: AETextFieldValidator!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtEmail.layer.borderColor = appColor.cgColor
        self.txtEmail.layer.borderWidth = 2
           txtEmail.addRegx(emailReg, withMsg: invalidEmail)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSendTapped(_ sender: Any) {
        if txtEmail.validate() == true{
            
            let params: Parameters = ["email":self.txtEmail.text!]
            
            self.forgotPassApiCall(parameters: params)
     
        }
        else{
            
        }
    }
    
    //MARK: Forgot Pass Api
    func forgotPassApiCall(parameters: Parameters){
        AccountApiInterface.sharedInstance.postRequestWithParam(fromViewController: self, actionName: "forgot_password", dictParam: parameters as [String : AnyObject], success: { (json) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyOtpViewController") as! VerifyOtpViewController
            vc.userID  = json["data"]["user_id"].stringValue
            vc.OTP  = json["data"]["otp"].stringValue
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        }) { (error) in
            self.showAlert(messageStr: error)
        }
        
    }
    
}
