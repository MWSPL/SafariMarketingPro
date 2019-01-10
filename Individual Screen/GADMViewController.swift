//
//  GADMViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 22/12/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit

class GADMViewController: UIViewController , UITextViewDelegate{
    @IBOutlet weak var VwHt: NSLayoutConstraint!
    @IBOutlet weak var ImgHeight: NSLayoutConstraint!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var fourthTextVw: UITextView!
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
            lbl4.font = .systemFont(ofSize: 22)
            firstTxtVw.font  = .systemFont(ofSize: 22)
            secondTxtVw.font  = .systemFont(ofSize: 22)
            thirdTxtVw.font  = .systemFont(ofSize: 22)
            fourthTextVw.font  = .systemFont(ofSize: 22)
            VwHt.constant = 2000
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
        navigationController?.navigationBar.shadowImage = UIImage()
        
        firstTxtVw.text = "To get you safari keyword ranked is still a dream for many safari companies. Google is the primary medium who can bring huge and high quality Traffic sources for your Business.It is most powerful and effective safari marketing ways ever found. We are helping our safari Clients in ranking their keywords with the most flexible marketing way called Google Ad-marketing. This platform shows you transparent results in terms of quality Trafic,leads and Customers."
        
        secondTxtVw.text = "To reach out your targeted Audience is not a worry any more. It deals with millions of searches by internet users every day then gives business owners a unique opportunity to convert many of these people into business leads and customers.\n\n➜ Google Adwords works faster than SEO\n\n➜ Increase brand awareness\n\n➜ Reach Safari Targeted Locations without any Hassells\n\n➜ Reconnect with visitors of your website\n\n➜ Measure your performance consistently\n\n➜ Tackle your competition better"
        
        thirdTxtVw.text = "➜ Search Ads -> In Internet marketing, search advertising is a method of placing online advertisements on web pages that show results from search engine queries.It reaches interested customers with a text ad. Ads are matched to search results pages based on the terms or Keywords that someone searches\n\n➜ Display Ads -> It displays the ad in search engine results page or in Social Media. On the Display Network, businesses instead place display ads on a huge network of sites across the internet. Display ads are the visual banner ads you see on advertising-supported sites everywhere highlighted."
        
        fourthTextVw.text = "➜ Reach\n\n➜ Engagement\n\n➜ Lead Generation\n\n➜ Sales and Revenue growth\n\n➜ Brand Awareness"
        
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
