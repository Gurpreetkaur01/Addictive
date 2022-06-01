

import UIKit
import WebKit

class YoutubeVideosViewController: UIViewController, WKUIDelegate , WKNavigationDelegate{

    var pageURL = "https://www.youtube.com/channel/UCH91lwXARYlQoSnDHHdT1fA"
    
    @IBOutlet var innerView: UIView!

    var webView: WKWebView!
    var progressView: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: pageURL)
        let req = NSURLRequest(url: url!)
        self.webView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.innerView.frame.width, height: self.innerView.frame.height))
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(req as URLRequest)
        webView.allowsLinkPreview = true
        webView.allowsBackForwardNavigationGestures = true
        webView.configuration.allowsAirPlayForMediaPlayback = true
        webView.configuration.allowsInlineMediaPlayback = true
        self.innerView.addSubview(webView)
        
        self.progressView = UIProgressView.init(frame: CGRect.init(x: 0, y: 0, width: self.innerView.frame.width, height: 2))
        self.progressView.progressTintColor = UIColor.red
        self.progressView.trackTintColor = UIColor.lightGray
        self.innerView.addSubview(self.progressView)
        
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(webView.url?.absoluteString ?? "")
        if (keyPath == "estimatedProgress") {
            progressView.isHidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finish loading")
        progressView.setProgress(0.0, animated: false)
        progressView.isHidden = true
    }
    
}
