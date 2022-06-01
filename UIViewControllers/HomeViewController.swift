
import UIKit

class HomeViewController: ViewController,UITableViewDataSource,UITableViewDelegate {

    
   
    @IBOutlet weak var tableView: UITableView!
    
    var apiData = JSON(JSON.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        let params: Parameters =  ["parent_id":standard.value(forKey: "user_id")]
        self.childListApiCall(parameters: params)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.apiData["data"].count
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ChildListTableViewCell
        
        let imageURL = apiData["data"][indexPath.row]["profile_pic"].stringValue
        cell.img.sd_setImage(with: URL(string: imageURL), placeholderImage: #imageLiteral(resourceName: "imgLogo"), options: [], completed: nil)
        
        cell.lblFirstName.text = apiData["data"][indexPath.row]["child_first_name"].stringValue
        cell.lblLastName.text = apiData["data"][indexPath.row]["child_last_name"].stringValue
        cell.lblBirthday.text = apiData["data"][indexPath.row]["birth"].stringValue

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 81
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         let vc = tableView.dequeueReusableCell(withIdentifier: "header")
        return vc?.contentView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrackingViewController")as! TrackingViewController
          vc.childLats = apiData["data"][indexPath.row]["latitude"].doubleValue
          vc.childLongs = apiData["data"][indexPath.row]["longitude"].doubleValue
        vc.childID = apiData["data"][indexPath.row]["child_id"].stringValue
        print(apiData["data"][indexPath.row]["child_id"].stringValue)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLogOutTapped(_ sender: UIButton) {
        
        let params: Parameters = ["user_id":standard.value(forKey: "user_id"),"type":standard.value(forKey: "user_type")]
        logoutApiCall(parameters: params)
        
        standard.setValue(nil, forKey: "user_type")
        standard.setValue(nil, forKey: "email")
        standard.setValue(nil, forKey: "user_id")
        
        appDelegates.window?.rootViewController?.removeFromParentViewController()
        appDelegates.welcomeViewConroller()
    }
    @IBAction func AddTapped(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddFamilyInfoViewController") as! AddFamilyInfoViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- Api Call Function
    
    func childListApiCall(parameters: Parameters){
        AccountApiInterface.sharedInstance.postRequestWithParam(fromViewController: self, actionName: "child_list", dictParam: parameters as [String : AnyObject], success: { (json) in
            
            self.apiData = json
            self.tableView.reloadData()
        
            
        }) { (error) in
            self.showAlert(messageStr: error)
        }
        
    }
    
    
    func logoutApiCall(parameters: Parameters){
        AccountApiInterface.sharedInstance.postRequestWithParam(fromViewController: self, actionName: "login", dictParam: parameters as [String : AnyObject], success: { (json) in

            
        }) { (error) in
        }
        
    }
}
