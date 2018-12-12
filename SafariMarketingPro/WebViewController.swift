//
//  WebViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 14/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import WebKit
import Tamamushi
import ASToast
import NVActivityIndicatorView

class WebViewController: UIViewController{
    var activityIndicator :NVActivityIndicatorView!
    @IBOutlet weak var navbar: UINavigationItem!
    var mainUrl = WebUrl()
    var baseUrl = String()
    var status : Bool = true
    @IBOutlet weak var webvw: UIWebView!
    override func viewDidLoad() {
        webvw.delegate = self
        super.viewDidLoad()
        if Reachability.isConnectedToNetwork() == true{
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
            self.webvw.loadRequest(URLRequest(url: URL(string: "\(self.mainUrl.safariUrl)\(self.baseUrl)")!))
            Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(WebViewController.stopper), userInfo: nil, repeats: false)
        }
        }
        else {
            self.view.makeToast(message: "You are not Connected to Internet",
                                backgroundColor: nil,
                                messageColor: UIColor.red)
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
    
    /// Back Button Function
    ///
    /// - Parameter sender: Any
    @IBAction func back(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    /// Url Choose Function
    func urlChoose(){
        if self.navbar.title == "SEO"{
            self.baseUrl = mainUrl.seoUrl
        }
        else if self.navbar.title == "SMM"{
            self.baseUrl = mainUrl.smmUrl
        }
        else if self.navbar.title == "EM"{
            self.baseUrl = mainUrl.emUrl
        }
        else if self.navbar.title == "CM"{
            self.baseUrl = mainUrl.cmUrl
        }
        else if self.navbar.title == "FB Ad Marketing"{
            self.baseUrl = mainUrl.fbadMarketingUrl
        }
        else if self.navbar.title == "Google Ad Marketing"{
            self.baseUrl = mainUrl.googleadMarketingUrl
        }
        else if self.navbar.title == "Youtube Ad Marketing"{
            self.baseUrl = mainUrl.YoutubeaddMarketingUrl
        }
        else if self.navbar.title == "Display Ad Marketing"{
            self.baseUrl = mainUrl.displayadMarketingUrl
        }
        else if self.navbar.title == "Logo"{
            self.baseUrl = mainUrl.logoUrl
        }
        else if self.navbar.title == "Website Design"{
            self.baseUrl = mainUrl.webDesignUrl
        }
        else if self.navbar.title == "Static and Dynamic Website"{
            self.baseUrl = mainUrl.statcndynamicUrl
        }
        else if self.navbar.title == "HTML/Wordpress/Joomla/PHP Websites"{
            self.baseUrl = mainUrl.htmlUrl
        }
        else if self.navbar.title == "Video Creation"{
            self.baseUrl = mainUrl.vcUrl
        }
        else if self.navbar.title == "Website reDesigning"{
            self.baseUrl = mainUrl.wredUrl
        }
        else if self.navbar.title == "Content Management System"{
            self.baseUrl = mainUrl.cmUrl
        }else if self.navbar.title == "Payment Integration"{
            self.baseUrl = mainUrl.pinteUrl
        }
        else if self.navbar.title == "Dedicated Booking forms"{
            self.baseUrl = mainUrl.dcBfUrl
        }
        else if self.navbar.title == "Domain"{
            self.baseUrl = mainUrl.domainUrl
        }
        else if self.navbar.title == "Hosting"{
            self.baseUrl = mainUrl.hostingUrl
        }
        else if self.navbar.title == "API Integration"{
            self.baseUrl = mainUrl.apiIntegrationUrl
        }
        else if self.navbar.title == "CRM"{
            self.baseUrl = mainUrl.crmUrl
        }
        else if self.navbar.title == "Email Solution"{
            self.baseUrl = mainUrl.esUrl
        }
        else if self.navbar.title == "Live chat"{
            self.baseUrl = mainUrl.lchatUrl
        }
        else if self.navbar.title == "Overview"{
            self.baseUrl = mainUrl.overview
        }
        else if self.navbar.title == "Team"{
            self.baseUrl = mainUrl.team
        }
        else if self.navbar.title == "Award & Recognition"{
            self.baseUrl = mainUrl.award
        }
        else if self.navbar.title == "Mission"{
            self.baseUrl = mainUrl.mission
        }else if self.navbar.title == "Vision"{
            self.baseUrl = mainUrl.vision
        }
        else if self.navbar.title == "FAQs"{
            self.baseUrl = mainUrl.faqs
        }
        else if self.navbar.title == "Term & Condition"{
            self.baseUrl = mainUrl.termsncn
        }
        else if self.navbar.title == "Privacy Policy"{
            self.baseUrl = mainUrl.privacypolicy
        }
        
    }
   
    
}
extension WebViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.status = false
        print("Sagar finish",self.status)
        activityIndicator.stopAnimating()
        print("Finished loading")
    }
    private func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        activityIndicator.stopAnimating()
        print("webview did fail load with error: \(error)")
    }
}
