
import UIKit

class ChildViewController: ViewController ,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var imgArrow: UIImageView!
    
     @IBOutlet weak var imgView: UIImageView!
    var videoArr = [String]()
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.layer.borderColor = appColor.cgColor
        imgView.layer.borderWidth = 1
       imgView.layer.cornerRadius = 5
        let imgUrl = standard.value(forKey: "image") as? String
         let name = standard.value(forKey: "name") as? String
        
        
        imgView.sd_setImage(with: URL(string: imgUrl ?? ""), completed: nil)
       lblName.text = name
        // Do any additional setup after loading the view.
        self.tableView.isHidden = true
        self.tableView.tableFooterView = UIView()
        
        videoArr = standard.object(forKey: "VideoArray") as? [String] ?? [String]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnViewVideos(_ sender: UIButton) {
        
         self.tableView.isHidden = !self.tableView.isHidden
        
        
    }
  
    
    @IBAction func youtubeVideos(_ sender: UIButton) {
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "YoutubeVideosViewController")as! YoutubeVideosViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    @IBAction func logOutTapped(_ sender: UIButton) {
        let params: Parameters = ["user_id":standard.value(forKey: "user_id"),"type":standard.value(forKey: "user_type")]
        logoutApiCall(parameters: params)
         standard.setValue(nil, forKey: "image")
         standard.setValue(nil, forKey: "name")
        standard.setValue(nil, forKey: "user_type")
        standard.setValue(nil, forKey: "email")
        standard.setValue(nil, forKey: "user_id")
          standard.setValue(nil, forKey: "VideoArray")
     
        appDelegates.window?.rootViewController?.removeFromParentViewController()
        appDelegates.welcomeViewConroller()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        let lbl = cell.viewWithTag(1) as! UILabel
        
        lbl.text = "Video  \(indexPath.row + 1)"
        cell.viewWithTag(2)?.layer.borderColor = appColor.cgColor
          cell.viewWithTag(2)?.layer.borderWidth = 1
           cell.viewWithTag(2)?.layer.cornerRadius = 5
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VideoPlayerViewController")as! VideoPlayerViewController
        vc.strURL = videoArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func logoutApiCall(parameters: Parameters){
        AccountApiInterface.sharedInstance.postRequestWithParam(fromViewController: self, actionName: "login", dictParam: parameters as [String : AnyObject], success: { (json) in
            
            
        }) { (error) in
        }
        
    }
}
