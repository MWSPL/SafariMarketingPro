//
//  LeftViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 13/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import Foundation
class LeftViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate,ExpandableHeaderViewDelegate , ButtonEffect {
    func AddBtn(_ tag: Int) {
        
    }
    weak var cellDelegate: ButtonEffect?
    
    @IBOutlet weak var tableview: UITableView!
    
    
    var sections = [
        
    
        Section(genre: "GOOGLE MARKETING" ,
                movies: ["SEO","SMM","EM","CM"], picture: ["search","smm","email","cm"],
                
                expanded: false
        ),
        Section(genre: "AD MARKETING" ,
                movies: ["FB Ad Marketing","Google Ad Marketing","Youtube Ad Marketing","Display Ad Marketing"], picture: ["fb","GAM","YAM","DAM"],
                
                expanded: false
        ),
        Section(genre: "DESIGN" ,
                movies: ["Logo","Website Design","Static and Dynamic Website","HTML/Wordpress/Joomla/PHP Websites","Video Creation","Website reDesigning"], picture: ["lg","WD","SD","hm","vc","vc"],
                
                expanded: false
        ),
        Section(genre: "DEVELOPMENT" ,
                movies: ["Content Management System","Payment Integration","Dedicated Booking forms"], picture: ["cmm","pi","cmm"],
                
                expanded: false
        ),
        Section(genre: "TECHNOLOGY" ,
                movies: ["Domain","Hosting","API Integration","CRM","Email Solution","Live chat"], picture: ["search","wh","ai","crm","email","lg"],
                
                expanded: false
        ),
        Section(genre: "ABOUT" ,
                movies: ["Overview","Team","Award & Recognition","Mission","Vision"," FAQs"], picture: ["ov","team","award","mission","vision","faq"],
                
                expanded: false
        ),
        Section(genre: "OTHER" ,
                movies: ["Term & Condition","Privacy Policy"], picture: ["WD","faq"],
                
                expanded: false
        ),
        Section(genre: "BLOG" ,
                movies : ["Blog"], picture: ["blog"],
                expanded: false
        ),
        Section(genre: "Contact" ,
                movies : ["Contact Us"], picture: ["faq"],
                expanded: false
        ),
        Section(genre: "Get a Quote" ,
                movies : ["Know More"],picture:["Gaq"],
                expanded: false
        ),
        Section(genre: "Portfolio" ,
                movies : ["Our Portfolio"],picture:["portfolio"],
                expanded: false
        )
        
    ]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].movies.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded) {
            
            return 44 // Height of inner View which contains sub part(e.g - "SEO","SMM","EM","CM" view)
        }
        else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5 // for Separation between two header view (e.g : Google Marketing and Ad Marketing)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.custominit(title: sections[section].genre, section: section, delegate: self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = tableView .dequeueReusableCell(withIdentifier: "labelCell")!
        let cell = tableView .dequeueReusableCell(withIdentifier: "labelCell") as! sideTableViewCell
        cell.textLabel?.text = sections[indexPath.section].movies[indexPath.row]
        cell.lblImg.image = UIImage(named: sections[indexPath.section].picture[indexPath.row])
        return cell
    }
    
    func toggleSection(header: ExpandableHeaderView, section: Int) {
        
       sections[section].expanded = !sections[section].expanded
        tableview.beginUpdates()
        for i in 0 ..< sections[section].movies.count {
            tableview.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
            tableview.endUpdates()
        }
       // tableview.endUpdates()
      /*  if sections[section].expanded == true{
            tableview.beginUpdates()
            for i in 0 ..< sections[section].movies.count {
                tableview.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
            }
            tableview.endUpdates()
            sections[section].expanded  = false
        }
        else if sections[section].expanded == false{
            tableview.beginUpdates()
            for i in 0 ..< sections[section].movies.count {
                tableview.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
            }
            tableview.endUpdates()
            sections[section].expanded  = true
        }*/
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.tableHeaderView  = self.tableview.tableHeaderView

        // Do any additional setup after loading the view.
    }
    

}
