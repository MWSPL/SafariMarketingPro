//
//  PortfolioViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 20/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import Tamamushi
extension PortfolioViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! pfcell
        //cell.backgroundColor = UIColor.clear// make cell more visible in our example project
        cell.imgvw.image = imgArr1[indexPath.row]
        cell.imgvw.contentMode = .scaleAspectFill
        cell.imgvw.clipsToBounds = true
        cell.webName.text = webnamee[indexPath.row]
        cell.layer.borderColor = UIColor(hexString: "#468fc5").cgColor
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 8
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 1
        var widthRemainingForCellContent = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let borderSize: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            widthRemainingForCellContent -= borderSize + ((cellsAcross - 1) * flowLayout.minimumInteritemSpacing)
        }
        let cellWidth = widthRemainingForCellContent / cellsAcross
        return CGSize(width: cellWidth, height: cellWidth)
    }
    // Collectionview click event function for visiting separate ViewControllers
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        //print("You selected cell #\(indexPath.item)!")
        
        if indexPath.item == 0{
            click.labelincell = "Bush2City"
            
        }
        if indexPath.item == 1{
            
            click.labelincell = "BigExpedetions"
        }
        if indexPath.item == 2{
            
            click.labelincell = "oltumuretoursandsafaris"
        }
        if indexPath.item == 3{
            click.labelincell = "safari-dmc"
        }
        if indexPath.item == 4{
            click.labelincell = "summit-trails"
        }
        if indexPath.item == 5{
            click.labelincell = "tatancasafaris"
        }
        let newViewController = UIStoryboard(name: "Dynamic", bundle: nil).instantiateViewController(withIdentifier: "ext")
        UIApplication.topViewController()?.present(newViewController, animated: true, completion: nil)
        
    }
    
}
class PortfolioViewController: UIViewController {
    let reuseIdentifier = "pfcll"
    var items = ["1", "2","3","4","5","6"]
    var imgArr1 : [UIImage] = [#imageLiteral(resourceName: "bus2"),#imageLiteral(resourceName: "twitter"),#imageLiteral(resourceName: "twitter"),#imageLiteral(resourceName: "twitter"),#imageLiteral(resourceName: "twitter"),#imageLiteral(resourceName: "twitter"),]
    var webnamee : [String] = ["Bus 2 City Adventures","Big Expeditions Safaris","Olumure Tour & Safaris","Safari DMC","Summit Trails Adventures","Tatanca Safaris"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

   
    /// Back Button Function
    ///
    /// - Parameter sender: Any
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
