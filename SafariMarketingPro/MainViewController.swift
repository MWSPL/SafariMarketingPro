//
//  MainViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 13/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
class MainViewController: SlideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient: CAGradientLayer = CAGradientLayer()
        
        gradient.colors = [UIColor(hexString:"#a0c04f").cgColor, UIColor(hexString:"#468fc5").cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.view.layer.insertSublayer(gradient, at: 0)
        // Do any additional setup after loading the view.
    }

}
