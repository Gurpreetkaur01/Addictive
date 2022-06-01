
import UIKit

class CreateAccountViewController: ViewController {
    @IBOutlet weak var txtEmail: AETextFieldValidator!
        @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtDateofBirth: AETextFieldValidator!
    @IBOutlet weak var txtRePassword: AETextFieldValidator!
    @IBOutlet weak var txtPassword: AETextFieldValidator!
    
    @IBOutlet weak var termView: UIView!
    var isCheckBoxEnable = Bool()
     let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setTextFieldBorder(textField: txtEmail)
        self.setTextFieldBorder(textField: txtPassword)
        self.setTextFieldBorder(textField: txtRePassword)
        self.setTextFieldBorder(textField: txtDateofBirth)
        
        txtEmail.addRegx(emailReg, withMsg: invalidEmail)
        txtPassword.addRegx(passwordReg, withMsg: invalidPassword)
          txtRePassword.addRegx(passwordReg, withMsg: invalidPassword)
       
        txtDateofBirth.addRegx(nameReg, withMsg: "Please enter valid Year of Birth")
        
        self.btnCheck.layer.borderColor = appColor.cgColor
        self.btnCheck.layer.borderWidth = 2
        
        datePicker.addTarget(self, action: #selector(self.dateChange(sender:)), for: .valueChanged)
        datePicker.datePickerMode = .date
        self.txtDateofBirth.inputView = datePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc  func dateChange(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtDateofBirth.text = formatter.string(from: datePicker.date)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCheckAction(_ sender: UIButton) {
        isCheckBoxEnable = !isCheckBoxEnable
        if isCheckBoxEnable == true {
           
               btnCheck.setImage(#imageLiteral(resourceName: "imgTick"), for: .normal)
        }
        else{
              btnCheck.setImage(nil, for: .normal)
        }
        
    }
 
    func setTextFieldBorder(textField : UITextField){
       textField.layer.borderColor = appColor.cgColor
        textField.layer.borderWidth = 2
        textField.leftview()
        
    }
    
    @IBAction func termsBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsViewController")as! TermsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func btnRegisterTapped(_ sender: Any) {
        
        if txtEmail.validate() == true && txtPassword.validate() == true && txtRePassword.validate() == true && txtDateofBirth.validate() == true {
            
            
            if isCheckBoxEnable == false{
                termView.shake(count: 2, for: 0.2, withTranslation: 10)
            }
            else{
                let parameter  : Parameters = [ "email" : txtEmail.text ?? "", "birth_year" : txtDateofBirth.text ?? "", "password" : txtPassword.text ?? "",
                                                "platform":"0", "device_id":deviceUUID, "notification_id": "\(standard.value(forKey: "gcm")!)"]
                
                self.signUpApiCall(parameters: parameter)
            }
            
            
           
        }
    }
    
    //MARK:- Api Call Function
    
    func signUpApiCall(parameters: Parameters){
        AccountApiInterface.sharedInstance.postRequestWithParam(fromViewController: self, actionName: "signup", dictParam: parameters as [String : AnyObject], success: { (json) in
                        
            self.showAlert(messageStr: "Registration Successful")
            
            self.navigationController?.popViewController(animated: true)
            
        }) { (error) in
            self.showAlert(messageStr: error)
        }
        
    }
    

}
