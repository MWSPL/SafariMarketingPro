//
//  ExternalWebsite.swift
//  SafariMarketingPro
//
//  Created by Sagar on 20/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import Tamamushi
import NVActivityIndicatorView
import ASToast
extension ExternalWebsite: UIWebViewDelegate {
    /// WebViewDidFinishLoad Method
    ///
    /// - Parameter webView: UIWebView
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.status = false
        print("Sagar finish",self.status)
        activityIndicator.stopAnimating()
        print("Finished loading")
    }
    /// didLoadwithError Function
    ///
    /// - Parameters:
    ///   - webView: UIWebView
    ///   - error: NSError
    private func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        activityIndicator.stopAnimating()
        print("webview did fail load with error: \(error)")
    }
}
class ExternalWebsite: UIViewController {
    var activityIndicator :NVActivityIndicatorView!
    @IBOutlet weak var navbar: UINavigationItem!
    @IBOutlet weak var webvw: UIWebView!
    var strinUrl = String()
    var status : Bool = true
    var mainUrl = WebUrl()
    override func viewDidLoad() {
        webvw.delegate = self
        super.viewDidLoad()

        let rect = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: 60,height: 60)
        )
        self.navbar.title = "\(click.labelincell)"
        activityIndicator = NVActivityIndicatorView(frame: rect,  type: NVActivityIndicatorType(rawValue: 3), color: UIColor.green)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        webvw.addSubview(activityIndicator)
        DispatchQueue.main.async {
            self.urlChoose()
            
            self.activityIndicator.startAnimating()
            self.webvw.loadRequest(URLRequest(url: URL(string: "\(self.strinUrl)")!))
           Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(ExternalWebsite.stopper), userInfo: nil, repeats: false)
        }
    }
    /// Stopper function for stopping the webview
    @objc func stopper(){
        print("sagar  :",self.status)
        if self.status == false{
            // for false condition no need to reload
            self.view.makeToast(message: "Loaded Successfully",
                                backgroundColor: nil,
                                messageColor: UIColor.red)
        }
        else {
         // for true condition needs to notify the slownwss of network
            
            activityIndicator.stopAnimating()
            self.webvw.stopLoading()
            self.view.makeToast(message: "Too slow Network Detected please go back and try again",
                                backgroundColor: nil,
                                messageColor: UIColor.red)
        }
        
        
    }
    
    /// Function for choosing URL for visiting different websites
    func urlChoose(){
        if click.labelincell == "Bush2City"{
            self.strinUrl = "\(mainUrl.bus2city)"
        }
        else if click.labelincell == "BigExpedetions"{
             self.strinUrl = "\(mainUrl.bigexpeditions)"
        }
        else if click.labelincell == "oltumuretoursandsafaris"{
            self.strinUrl = "\(mainUrl.oltumuretoursandsafaris)"
        }
        else if click.labelincell == "safari-dmc"{
            self.strinUrl = "\(mainUrl.safariDmc)"
        }
        else if click.labelincell == "summit-trails"{
            self.strinUrl = "\(mainUrl.summittrails)"
        }
        else if click.labelincell == "tatancasafaris"{
            self.strinUrl = "\(mainUrl.tatanca)"
        }
    }
    
    /// Back Button function
    ///
    /// - Parameter sender: Any
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
