//
//  CMTableViewCell.swift
//  SafariMarketingPro
//
//  Created by Sagar on 21/12/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit

class CMTableViewCell: UITableViewCell {

    @IBOutlet weak var ImgVwHt: NSLayoutConstraint!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var TxtVw: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            ImgVwHt.constant = 270
            TxtVw.font = .systemFont(ofSize: 22)
        }
    }
}
