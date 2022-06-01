
import UIKit
import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var playOut: UIButton!
    
    @IBOutlet weak var videoView: UIView!
    
    
    var videoUrl = URL(string: "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4")
    var strURL = ""
    var player = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
            self.videoSetup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func videoSetup(){
        let vidURL = URL(string: strURL)
//        let vidURL = videoUrl
        self.player = AVPlayer(url: vidURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect.init(x: 0, y: 0, width: self.videoView.frame.width, height: self.videoView.frame.height)
        self.videoView.layer.addSublayer(playerLayer)
        self.player.play()
        self.playOut.setTitle("Pause", for: .normal)
    }
    

    @IBAction func backBtn(_ sender: UIButton) {
                self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playBtn(_ sender: UIButton) {
        if sender.titleLabel?.text == "Pause"{
            sender.setTitle("Play", for: .normal)
            self.player.pause()
        }
        else{
            sender.setTitle("Pause", for: .normal)
            self.player.play()
        }
    }
    

}
