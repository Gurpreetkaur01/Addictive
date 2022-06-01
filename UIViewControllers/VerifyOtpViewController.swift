
import UIKit

class VerifyOtpViewController : ViewController ,UITextFieldDelegate{
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt3: UITextField!
    @IBOutlet weak var txt4: UITextField!
    
    @IBOutlet weak var otpView: UIView!
   
    var userID =  ""
    var OTP = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        self.resignFirstResponder()
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitBtntapped(_ sender: Any) {
        
        self.resignFirstResponder()
           if txt1.text != "" && txt2.text != "" && txt3.text != "" && txt4.text != "" {
            let userOTP = txt1.text! + txt2.text! + txt3.text! + txt4.text!
            
            if userOTP == self.OTP{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "UpdatePasswordViewController") as! UpdatePasswordViewController
                vc.userID = self.userID
                self.navigationController?.pushViewController(vc, animated: true)
            } else{
                otpView.shake(count: 2, for: 0.2, withTranslation: 10)

            }
        }
        else{
           otpView.shake(count: 2, for: 0.2, withTranslation: 10)
        }
        
       
    }
    @IBAction func textFieldChange(_ sender: UITextField) {
        
        
        
    }
    
    
    
    
        func resignAllResponder(){
        txt1.resignFirstResponder()
        txt2.resignFirstResponder()
        txt3.resignFirstResponder()
        txt4.resignFirstResponder()
    }
    
    
    
    
    //MARK:-TextField Delegates
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let next:NSInteger
        
        if string == "" {
            
            next = textField.tag - 1;
           
        }
        else{
            
            next = textField.tag + 1;
           
        }
        
        if (textField.text?.characters.count)! >= 1 {
            
            if textField.tag == 4 {
                
                if string == "" {
                    
                    textField.text = ""
                    
                    let temptf = self.view.viewWithTag(next) as! UITextField
                    
                    temptf.becomeFirstResponder()
                   
                    return false
                    
                }
                else{
                    
                    if (textField.text?.characters.count)! > 1 {
                        
                        let stringg = textField.text!
                        textField.text = stringg.replacingOccurrences(of: stringg, with: string)
                    }
                  
                    return false
                }
            }
            else{
                if string == "" {
                    
                    textField.text = ""
                    
                    if next != 0 {
                        
                        let temptf = self.view.viewWithTag(next) as! UITextField
                        temptf.becomeFirstResponder()
                        
                    }
                   
                    return false
                }
                    
                else{
                    
                    if (textField.text?.characters.count)! > 1 {
                        
                        
                        let stringg = textField.text!
                        textField.text = stringg.replacingOccurrences(of: stringg, with: string)
                        
                    }
                    
                    let temptf = self.view.viewWithTag(next) as! UITextField
                  
                    temptf.becomeFirstResponder()
                    
                }
            }
        }

        return true
        
        
    }
    
    
}

