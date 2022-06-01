

import UIKit
let appDelegates = UIApplication.shared.delegate as! AppDelegate

//let baseUrl = "http://localhost/kidictive/index.php/api/"
let baseUrl = "http://54.245.141.246/kidictive/index.php/api/"

let standard = UserDefaults.standard

let nameReg = "^.{1,600}$"
let invalidName = "Invaid Data"

let emailReg = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
let invalidEmail = "Please Enter valid Email"

let passwordReg = "^.{6,50}$"
let invalidPassword = "Please enter valid password"

let deviceUUID : String = (UIDevice.current.identifierForVendor?.uuidString)!
  let coinsIAP = "com.iap.coins"


var appDelegatesApplication : UIApplication?

let appColor = UIColor.init(red: 0.0, green: 23.0/255.0, blue: 250.0/255.0, alpha: 1.0)





