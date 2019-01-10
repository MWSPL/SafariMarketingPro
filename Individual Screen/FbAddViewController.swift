//
//  FbAddViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 22/12/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit

class FbAddViewController: UIViewController , UITextViewDelegate{
    @IBOutlet weak var VwHt: NSLayoutConstraint!
    @IBOutlet weak var ImgHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var secondTxtVw: UITextView!
    @IBOutlet weak var firstTxtVw: UITextView!
    @IBOutlet weak var thirdTxtVw: UITextView!
    @IBOutlet weak var myScroll: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            lbl1.font = .systemFont(ofSize: 22)
            ImgHeight.constant = 500
            lbl2.font = .systemFont(ofSize: 22)
            lbl3.font = .systemFont(ofSize: 22)
            firstTxtVw.font  = .systemFont(ofSize: 22)
            secondTxtVw.font  = .systemFont(ofSize: 22)
            thirdTxtVw.font  = .systemFont(ofSize: 22)
            VwHt.constant = 1600
        }
        // For ScrollView bakground color
        let gradient2: CAGradientLayer = CAGradientLayer()
        gradient2.colors = [UIColor(hexString:"#a0c04f").cgColor, UIColor(hexString:"#468fc5").cgColor]
        gradient2.locations = [0.0 , 1.0]
        gradient2.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient2.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient2.frame = CGRect(x: 0.0, y: 0.0, width: self.myScroll.frame.width, height: self.myScroll.frame.height)
        self.myScroll.layer.insertSublayer(gradient2, at: 0)
        if #available(iOS 11.0, *) {
            self.myScroll.contentInsetAdjustmentBehavior = .never
        }
        // navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        firstTxtVw.text = "Do you know facebook having more than 1.8 billion people? When your targeted safari audience spent most of their time on face book, Are you even aware of the benefits face book Advertisements can bring to your safari business? face book ads can immensely increase your visibility to your audience of different demographics such as age, interests, behaviour, and location."
        secondTxtVw.text = "You are losing Customers every day if your safari business is not advertising on Facebook. Here’s why.\n\n➜ Facebook advertising is the most targeted form of advertising\n\n➜ It is cost effective and fast\n\n➜ It increases safari brand awareness\n\n➜ It increases website traffic in your safari website\n\n➜ Facebook advertising increases revenue, sales, and leads\n\n➜ Facebook advertising can drive repeat safari customers for your business"
        thirdTxtVw.text = "➜ Traffic Generation\n\n➜ Lead Generation\n\n➜ Sales growth\n\n➜ Branding and engagement"
        
    }
    
    @IBAction func Back(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func SignUp(_ sender: Any) {
        if Reachability.isConnectedToNetwork() == true{
            let newViewController = UIStoryboard(name: "Dynamic", bundle: nil).instantiateViewController(withIdentifier: "quote")
            UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
        }
        else {
            
            let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "internet")
            UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
        }
    }
    
}
