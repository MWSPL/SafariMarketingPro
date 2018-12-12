//
//  ExpandableHeaderView.swift
//  Foodzo
//
//  Created by Sagar on 25/10/1939 Saka.
//  Copyright © 1939 Sadyogi. All rights reserved.
//

import UIKit
protocol ExpandableHeaderViewDelegate{
    
    func toggleSection(header: ExpandableHeaderView, section: Int)
    
    
}
class ExpandableHeaderView: UITableViewHeaderFooterView {
    
    
    var delegate: ExpandableHeaderViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer) {
        
        let cell = gestureRecognizer.view as! ExpandableHeaderView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func custominit(title: String, section: Int, delegate: ExpandableHeaderViewDelegate){
        
        self.textLabel?.text = title
        self.section = section
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        self.textLabel?.textColor  = UIColor(hexString:"#468fc5")
        self.contentView.backgroundColor = UIColor.darkGray
        
    }
    


}
