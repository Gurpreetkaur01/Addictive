

import UIKit


extension String {
    func dropLast(_ n: Int = 1) -> String {
        return String(dropLast(n))
    }
    var dropLast: String {
        return dropLast()
    }
    
    func dropFirst(_ n: Int = 1) -> String {
        return String(dropFirst(n))
    }
    var dropFirst: String {
        return dropFirst()
    }
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return ""
    }
    
    func base64Decoded() -> String? {
        var base64Encoded = self
        
        if base64Encoded.characters.last == "\n"{
            base64Encoded.characters.removeLast()
        }
        
        
        if Data(base64Encoded: base64Encoded) == nil{
            
            return self
            
        } else{
            
            let decodedData = Data(base64Encoded: base64Encoded)!
            
            if String(data: decodedData, encoding: .utf8) == nil{
                return self
            }
            
            
            let decodedString = String(data: decodedData, encoding: .utf8)!
            
            return decodedString
        }
    }
    
}

extension UIDevice {
    static var isIphoneX: Bool {
        var modelIdentifier = ""
        if isSimulator {
            modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
        } else {
            var size = 0
            sysctlbyname("hw.machine", nil, &size, nil, 0)
            var machine = [CChar](repeating: 0, count: size)
            sysctlbyname("hw.machine", &machine, &size, nil, 0)
            modelIdentifier = String(cString: machine)
        }
        
        return modelIdentifier == "iPhone10,3" || modelIdentifier == "iPhone10,6"
    }
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
    
   
    
    
    
}

extension UITextField{
    func leftview(){
        let vc = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        
        self.leftView = vc
        self.leftViewMode = .always
    }
    func rightVC(){
        let vc = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        
        self.rightView = vc
        self.rightViewMode = .always
    }
    func leftviewWithImage(image :UIImage){
        let vc = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 34))
        let btnLeft = UIButton(frame: CGRect(x: 8, y: 2, width: 30, height: 30))
        btnLeft.setImage(image, for: .normal)
        btnLeft.isUserInteractionEnabled = false
        vc.addSubview(btnLeft)
        self.leftView = vc
        self.leftViewMode = .always
    }
    
    func leftview(image :UIImage){
        let vc = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
        let btnLeft = UIButton(frame: CGRect(x: 8, y: 15, width: 14, height: 14))
        btnLeft.setImage(image, for: .normal)
        btnLeft.isUserInteractionEnabled = false
        vc.addSubview(btnLeft)
        self.leftView = vc
        self.leftViewMode = .always
    }
    
    func rightview(Img:UIImage ){
        let vc = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 44))
        let btnLeft = UIButton(frame: CGRect(x: 10, y: 15, width: 14, height: 14))
        btnLeft.setImage(Img, for: .normal)
        btnLeft.isUserInteractionEnabled = false
        
        vc.addSubview(btnLeft)
        self.rightView = vc
        self.rightViewMode = .always
    }
    
    
    func borderColor(){
        self.layer.borderColor = UIColor(red: 225/255, green: 162/255, blue: 136/255, alpha: 1.0).cgColor
        
        self.layer.borderWidth = 1.0;
    }
    func addshodowToTextField(){
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        
        
    }
    
    
}
extension UIButton {
    func addshodowToButton(){
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.init(width: 0.5, height: 0.5)
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        
    }
}


extension UITextView {
    
    func addshodowToTextView(){
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = true
        
        
        
    }
    
    
    
    
}


extension UIView{

        
        func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {
            
            let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            animation.repeatCount = count
            animation.duration = duration/TimeInterval(animation.repeatCount)
            animation.autoreverses = true
            animation.fromValue = NSValue(cgPoint: CGPoint(x: CGFloat(-translation), y: self.center.y))
            animation.toValue = NSValue(cgPoint: CGPoint(x: CGFloat(translation), y: self.center.y))
            layer.add(animation, forKey: "shake")
        }
    
    
    
    func startIndicator(){
        let vc = UIActivityIndicatorView()
        vc.center  = self.center
        vc.activityIndicatorViewStyle = .whiteLarge
        vc.color = appColor
        vc.tag = 1000
        self.isUserInteractionEnabled = false
        vc.startAnimating()
        self.addSubview(vc)
        
    }
    
    func stopIndicator(){
        let vc =  self.viewWithTag(1000) as? UIActivityIndicatorView
        self.isUserInteractionEnabled = true
        vc?.stopAnimating()
        vc?.removeFromSuperview()
        
    }
    
    
    func circularShadow(){
      
        self.clipsToBounds = true
        self.layer.masksToBounds = false
    
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2.0
        self.layoutIfNeeded()
        
        
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        
        
    }
    
    
    
    func addshodowToView(){
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.masksToBounds = false
        
    }
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    func corner(demoView: UIView){
        let maskPath = UIBezierPath(roundedRect: demoView.bounds,
                                    byRoundingCorners: [.bottomLeft,.bottomRight],
                                    cornerRadii: CGSize(width: demoView.frame.size.width, height: demoView.frame.size.width))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        demoView.layer.mask = maskLayer
    }
}


extension UIViewController{
    
    func showAlert(messageStr :String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: messageStr as String, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}




