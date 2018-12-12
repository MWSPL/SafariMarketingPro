//
//  ContainerViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 13/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
class ContainerViewController:  SlideMenuController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.addLeftBarButtonWithImage(UIImage(named: "menu")!)
        }
    }
    override func awakeFromNib() {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Main") {
            self.mainViewController = controller
        }
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "Left") {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }

    /// Menu Buttom
    ///
    /// - Parameter sender: Any
    @IBAction func menu(_ sender: Any) {
        if self.slideMenuController() != nil {
            //slideMenuController.addLeftBarButtonWithImage(UIImage(named: "menu")!)
            // Open
            self.slideMenuController()?.openLeft()
            self.slideMenuController()?.openRight()
            
            // close
            self.slideMenuController()?.closeLeft()
            self.slideMenuController()?.closeRight()
        }
        
        
    }
}
