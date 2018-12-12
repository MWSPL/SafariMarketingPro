//
//  sideTableViewCell.swift
//  SafariMarketingPro
//
//  Created by Sagar on 14/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import ASToast
protocol ButtonEffect : class {
    func AddBtn(_ tag:Int)
}
struct click {
  static var labelincell = String()
}
class sideTableViewCell: UITableViewCell {

    @IBOutlet weak var lblImg: UIImageView!
    @IBOutlet weak var label: UILabel!
    var labell = String()
    weak var cellDelegate: ButtonEffect?
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func topMostController() -> UIViewController {
        var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    /// Buttom over Cell for getting click event
    ///
    /// - Parameter sender: Any
    @IBAction func buttonEffect(_ sender: Any) {
        cellDelegate?.AddBtn(self.tag)
        click.labelincell = label.text!
        print(click.labelincell)
        if click.labelincell == "Blog"{
            // Blog Page
            if Reachability.isConnectedToNetwork() == true{
            let newViewController = UIStoryboard(name: "Dynamic", bundle: nil).instantiateViewController(withIdentifier: "blog")
            UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            else {
                
                let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "internet")
                UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            
        }
        else if click.labelincell == "Contact Us"{
            //Contact Us Page
            if Reachability.isConnectedToNetwork() == true{
            let newViewController = UIStoryboard(name: "Dynamic", bundle: nil).instantiateViewController(withIdentifier: "contact")
            UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            else{
                
                let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "internet")
                UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
 
                
            }
        }
            //Know More
        else if click.labelincell == "Know More"{
            if Reachability.isConnectedToNetwork() == true{
            let newViewController = UIStoryboard(name: "Dynamic", bundle: nil).instantiateViewController(withIdentifier: "quote")
            UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            else {
                
                let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "internet")
                UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            
        }
            //Portfolio
        else if click.labelincell == "Our Portfolio"{
            if Reachability.isConnectedToNetwork() == true{
            let newViewController = UIStoryboard(name: "Dynamic", bundle: nil).instantiateViewController(withIdentifier: "pfolio")
            UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            else {
                
                let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "internet")
                UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            
        }
        else{
            // Normal Web view
            if Reachability.isConnectedToNetwork() == true{
            let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "web")
            UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
            else {
                
                let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "internet")
                UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
            }
           
        }
    }
}
