
import UIKit
import EFInternetIndicator
class ViewController: UIViewController , InternetStatusIndicable{
    var internetConnectionIndicator: InternetViewIndicator?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startMonitoringInternet()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

