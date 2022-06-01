

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Buttons Actions
    @IBAction func registerBtn(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController")as! CreateAccountViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  

}
