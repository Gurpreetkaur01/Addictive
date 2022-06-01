

import UIKit
import CoreLocation
class LoginViewController: ViewController,CLLocationManagerDelegate {
    
    
    
    @IBOutlet var registerOut: UIButton!
    @IBOutlet var orOut: UILabel!
    @IBOutlet var forgotPassOut: UIButton!
    @IBOutlet var lineOut: UILabel!
    
    var locationManager = CLLocationManager()
    var location = CLLocation()
    @IBOutlet weak var txtUserName: AETextFieldValidator!
     var isCheckBoxEnable = Bool()
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtPassword: AETextFieldValidator!
    var userType = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtPassword.layer.borderColor = appColor.cgColor
         self.txtPassword.layer.borderWidth = 2
        
        self.txtUserName.layer.borderColor = appColor.cgColor
        self.txtUserName.layer.borderWidth = 2
        self.btnCheck.layer.borderColor = appColor.cgColor
        self.btnCheck.layer.borderWidth = 2
        self.coreLocationFunction()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if self.userType == "child"{
            self.orOut.isHidden = true
            self.registerOut.isHidden = true
            self.forgotPassOut.isHidden = true
            self.lineOut.isHidden = true

        } else{
            self.orOut.isHidden = false
            self.registerOut.isHidden = false
            self.forgotPassOut.isHidden = false
            self.lineOut.isHidden = false
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func btnCreateAccountTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        
    
        if txtUserName.validate() == true && txtPassword.validate() {
         

                let parameter  : Parameters = [ "email" : txtUserName.text ?? "", "login_type" : userType, "password" : txtPassword.text ?? "",
                                                "platform":"0", "device_id":deviceUUID, "notification_id": "\(standard.value(forKey: "gcm")!)","latitude":"\(location.coordinate.latitude)","longitude":"\(location.coordinate.longitude)"]

                self.loginUpApiCall(parameters: parameter)



        }
    }
    //MARK:- Api Call Function
    
    func loginUpApiCall(parameters: Parameters){
        AccountApiInterface.sharedInstance.postRequestWithParam(fromViewController: self, actionName: "login", dictParam: parameters as [String : AnyObject], success: { (json) in
            
            
            print(json)
            if parameters["login_type"] as? String == "parent"{
                  standard.setValue(json["data"]["parent_id"].stringValue, forKey: "user_id")
                standard.setValue(self.txtUserName.text!, forKey: "email")
                standard.setValue(self.userType, forKey: "user_type")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                standard.setValue(json["data"]["child_id"].stringValue, forKey: "user_id")
                standard.setValue(self.txtUserName.text!, forKey: "email")
                standard.setValue(self.userType, forKey: "user_type")
                
        
                standard.setValue(json["data"]["image"].stringValue, forKey: "image")
                standard.setValue(json["data"]["first_name"].stringValue + " "  + json["data"]["last_name"].stringValue, forKey: "name")
                
                var array = [String]()
                
               
                for i in 0..<json["videos"].arrayValue.count {
                    
                    array.append(json["videos"][i]["video_url"].stringValue)
                }
                  standard.set(array, forKey: "VideoArray")
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChildViewController") as! ChildViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
          
           
            
            
            
            
        }) { (error) in
            self.showAlert(messageStr: error)
        }
        
    }
    //MARK:- Accept Permission Functions
    func coreLocationFunction(){
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did location updates is called")
        let userLocation:CLLocation = locations[0] as CLLocation
        location = userLocation
        manager.stopUpdatingLocation()
        
        
    }
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Did location updates is called but failed getting location \(error)")
    }
    
    
    func isAuthorizedtoGetUserLocation() {
        
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
}
