//
//  InternetViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 17/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import Tamamushi
extension UIApplication {
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
class InternetViewController: UIViewController {
    @IBOutlet weak var retrybtn: UIButton!
    var activityIndicator :NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: 60,height: 60)
        )
        activityIndicator = NVActivityIndicatorView(frame: rect,  type: NVActivityIndicatorType(rawValue: 3), color: UIColor.red)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
       self.view.addSubview(activityIndicator)
     
    }
    /// When Internet Avaliable this function is going to be called
    @objc func afterConnect(){
     
     //   performSegue(withIdentifier: "tomain", sender: nil)
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nav")
        UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
    }
    /// For Enabling the retry button this Function is called
    @objc func enableButton() {
        if Reachability.isConnectedToNetwork() == true{
            activityIndicator.stopAnimating()
            self.view.makeToast(message: "You are connected Redirecting..",
                                backgroundColor: nil,
                                messageColor: UIColor.green)
            Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(InternetViewController.afterConnect), userInfo: nil, repeats: false)
        }
        else{
            activityIndicator.stopAnimating()
            self.view.makeToast(message: "Please Try Again ...",
                                backgroundColor: nil,
                                messageColor: UIColor.red)
            self.retrybtn.isEnabled = true
        }
    }
    /// Retry Button Click Funcion for checking Network avaliability
    ///
    /// - Parameter sender: Any
    @IBAction func btnClick(_ sender: Any) {
        
        activityIndicator.startAnimating()
        self.view.makeToast(message: "Please wait...",
                            backgroundColor: nil,
                            messageColor: UIColor.red)
        self.retrybtn.isEnabled = false
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(InternetViewController.enableButton), userInfo: nil, repeats: false)
        
    }
}
