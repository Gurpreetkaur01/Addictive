
import UIKit

class WelcomeViewController: ViewController {

    //MARK: VARIABLES
    @IBOutlet var imgLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Buttons ACtions
    @IBAction func btnImKidTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
           vc.userType =  "child"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnImParentTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
         vc.userType =  "parent"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func logoBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController")as! AboutViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
