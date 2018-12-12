//
//  ContactUsViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 15/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import Tamamushi
import ASToast
import MessageUI
import Alamofire
import Foundation
import NVActivityIndicatorView
// MARK: - textField Extension for showing empty field required for validation
extension UITextField {
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}
// MARK: - Extension for Getting collectionview delegateFlowLayout
extension ContactUsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellsAcross: CGFloat = 4
        var widthRemainingForCellContent = collectionView.bounds.width
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let borderSize: CGFloat = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            widthRemainingForCellContent -= borderSize + ((cellsAcross - 1) * flowLayout.minimumInteritemSpacing)
        }
        let cellWidth = widthRemainingForCellContent / cellsAcross
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    func isValidInput(Input:String) -> Bool {
        let RegEx = "\\w{3,18}"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: Input)
    }
    func isValidUsername(testStr:String) -> Bool {
        
        let rawString: String = testStr
        let whitespace: NSCharacterSet = NSCharacterSet.whitespacesAndNewlines as NSCharacterSet
        //trimmed = rawString.stringByTrimmingCharactersInSet(whitespace)
        var trimmed = rawString.trimmingCharacters(in: whitespace as CharacterSet)
        if trimmed.characters.count>20
        {
            
            return true
        }
        else
        {
            
            return false
        }
        
    }
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    func isValidUrl(url: String) -> Bool {
       // let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
       // let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
}

class ContactUsViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UITextFieldDelegate , MFMailComposeViewControllerDelegate{
    struct Global {
        static var responseMsg = String()
        static var final = NSDictionary()
        static var message = String()
    }
    var activityIndicator :NVActivityIndicatorView!
    let reuseIdentifier = "cell"
    var items = ["1", "2","3","4","5","6","7","8"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! socialcell
       // cell.backgroundColor = UIColor.black// make cell more visible in our example project
        cell.cellImage.image = imgArr1[indexPath.row]
        cell.cellImage.contentMode = .scaleAspectFill
        cell.cellImage.clipsToBounds = true
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 8
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        //let url = NSURL(string: "https://instagram.com/foodzo.in")
        //UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        if indexPath.item == 0 {
            if let url = URL(string: "tel://\(phone1)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        if indexPath.item == 1{
            if Reachability.isConnectedToNetwork() == true{
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = (self as MFMailComposeViewControllerDelegate)
            mail.setToRecipients(["sales@manoramaseoservice.com"])
                mail.setSubject("")
                mail.setMessageBody("", isHTML: true)
                present(mail, animated: true, completion: nil)
            } else {
                let alertController1 = UIAlertController(title:"No Mail App In your Phone Please write us on ", message: "sales@manoramaseoservice.com", preferredStyle: UIAlertControllerStyle.alert)
                let ok1 = UIAlertAction(title: "✅", style: UIAlertActionStyle.default, handler:nil)
                alertController1.addAction(ok1)
                present(alertController1, animated: true, completion: nil)
            }
            }
            else {
                self.view.makeToast(message: "You are not Connected to Internet",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
            }
            
        }
        if indexPath.item == 2{
            if Reachability.isConnectedToNetwork() == true{
            let url = NSURL(string: "https://www.facebook.com/ManoramaSEOservice")
            
            if UIApplication.shared.canOpenURL(url! as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            } else {
                //redirect to safari because the user doesn't have Instagram
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            }
            else {
                self.view.makeToast(message: "You are not Connected to Internet",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
            }
        }
        if indexPath.item == 3{
            if Reachability.isConnectedToNetwork() == true{
            //https://twitter.com/Manoramaseo
            let url = NSURL(string: "https://twitter.com/Manoramaseo")
            
            if UIApplication.shared.canOpenURL(url! as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            } else {
                //redirect to safari because the user doesn't have Instagram
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            }
            else {
                self.view.makeToast(message: "You are not Connected to Internet",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
            }
        }
        if indexPath.item == 4 {
            if Reachability.isConnectedToNetwork() == true{
            //https://www.linkedin.com/in/manoramaseoservice
            let url = NSURL(string: "https://www.linkedin.com/in/manoramaseoservice")
            
            if UIApplication.shared.canOpenURL(url! as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            } else {
                //redirect to safari because the user doesn't have Instagram
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            }
            else {
                self.view.makeToast(message: "You are not Connected to Internet",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
            }
        }
        if indexPath.item == 5{
            if Reachability.isConnectedToNetwork() == true{
            //https://plus.google.com/u/0/+Manoramaseoservice
            let url = NSURL(string: "https://plus.google.com/u/0/+Manoramaseoservice")
            
            if UIApplication.shared.canOpenURL(url! as URL) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            } else {
                //redirect to safari because the user doesn't have Instagram
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            }
            else{
                self.view.makeToast(message: "You are not Connected to Internet",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
            }
        }
        if indexPath.item == 6{
            if Reachability.isConnectedToNetwork() == true{
            //https://www.youtube.com/watch?v=tbxzoVhlOs0
            }
            else
            {
                self.view.makeToast(message: "You are not Connected to Internet",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
            }
        }
        if indexPath.item == 7{
            if Reachability.isConnectedToNetwork() == true{
                
            }
            else {
                self.view.makeToast(message: "You are not Connected to Internet",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
            }
        }
    }
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var nametfielf: UITextField!
    @IBOutlet weak var WEBSITE: UITextField!
    @IBOutlet weak var PHONE: UITextField!
    @IBOutlet weak var EMAIL: UITextField!
    @IBOutlet weak var MESSAGE: UITextView!
    var imgArr1 : [UIImage] = [#imageLiteral(resourceName: "phone"),#imageLiteral(resourceName: "eml"),#imageLiteral(resourceName: "facebook"),#imageLiteral(resourceName: "twitter"),#imageLiteral(resourceName: "linkedin"),#imageLiteral(resourceName: "plusgoogle"),#imageLiteral(resourceName: "youtube"),#imageLiteral(resourceName: "instagram")]
    let phone1 = "+91-700-873-8714"
    @IBOutlet weak var imgvw: UIImageView!
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail cancelled")
        case MFMailComposeResult.saved:
            print("Mail saved")
        case MFMailComposeResult.sent:
            print("Mail sent")
        case MFMailComposeResult.failed:
            print("Mail sent failure: \(String(describing: error?.localizedDescription))")
        }
        
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
        imgvw.contentMode = .scaleAspectFill
        imgvw.clipsToBounds = true
        let rect = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: 60,height: 60)
        )
        activityIndicator = NVActivityIndicatorView(frame: rect,  type: NVActivityIndicatorType(rawValue: 3), color: UIColor.red)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        self.view.addSubview(activityIndicator)
        
        nametfielf.delegate = self
        EMAIL.delegate = self
        PHONE.delegate = self
        WEBSITE.delegate = self
        let myColor = UIColor.lightGray
        nametfielf.layer.borderColor = myColor.cgColor
        EMAIL.layer.borderColor = myColor.cgColor
        PHONE.layer.borderColor = myColor.cgColor
        WEBSITE.layer.borderColor = myColor.cgColor
        MESSAGE.layer.borderColor = myColor.cgColor
        
        nametfielf.layer.cornerRadius = 15.0
        EMAIL.layer.cornerRadius = 15.0
        PHONE.layer.cornerRadius = 15.0
        WEBSITE.layer.cornerRadius = 15.0
        nametfielf.layer.borderWidth = 2.0
        EMAIL.layer.borderWidth = 2.0
        PHONE.layer.borderWidth = 2.0
        WEBSITE.layer.borderWidth = 2.0
        MESSAGE.layer.borderWidth = 2.0
        self.hideKeyboardWhenTappedAround() // for keyboard hide
        
        // NAME
        
        nametfielf.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "user")
        imageView.image = image
        nametfielf.leftView = imageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // EMAIL
        
        EMAIL.leftViewMode = .always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image1 = UIImage(named: "emee")
        imageView1.image = image1
        EMAIL.leftView = imageView1
        imageView1.contentMode = .scaleAspectFill
        imageView1.clipsToBounds = true
     
        
        // PHONE
        
        PHONE.leftViewMode = .always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image2 = UIImage(named: "cell")
        imageView2.image = image2
        PHONE.leftView = imageView2
        imageView2.contentMode = .scaleAspectFill
        imageView2.clipsToBounds = true
        // WEBSITE
        
        WEBSITE.leftViewMode = .always
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image3 = UIImage(named: "website")
        imageView3.image = image3
        WEBSITE.leftView = imageView3
        imageView3.contentMode = .scaleAspectFill
        imageView3.clipsToBounds = true

    }

    /// SubmitBtn Function for Sending inputs to server
    ///
    /// - Parameter sender: Any
    @IBAction func SubmitBtn(_ sender: Any) {
        
        if (nametfielf.text?.isEmpty)! || (EMAIL.text?.isEmpty)! || (PHONE.text?.isEmpty)! || (WEBSITE.text?.isEmpty)! || (MESSAGE.text.isEmpty)
        {
            // Toast Message for Each empty field
            if (nametfielf.text?.isEmpty)!{
                self.view.makeToast(message: "Please Check Your Name!",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                 nametfielf.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }

            else if (EMAIL.text?.isEmpty)!{
                self.view.makeToast(message: "Please Check Your email!",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                 EMAIL.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
            else if (PHONE.text?.isEmpty)!{
                self.view.makeToast(message: "Check Your Phone Number!",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                 PHONE.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
            else if (MESSAGE.text.isEmpty){
                self.view.makeToast(message: "Message field Should not Empty!",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                
            }
            else{
                self.view.makeToast(message: "Please Check Your website!",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                 WEBSITE.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
        }
        else {
            
            if (EMAIL.text?.isValidEmail())! && (PHONE.text?.isPhoneNumber)! && ((nametfielf.text?.isValidInput(Input: nametfielf.text!) != false)) && ((WEBSITE.text?.isValidUrl(url: WEBSITE.text!)) != false) && (MESSAGE.text.isValidUsername(testStr: MESSAGE.text!) != false)
            {
                if Reachability.isConnectedToNetwork() == true{
                // JSON Parsing for POST data to backend
                self.view.makeToast(message: "All Ok go for Parsing",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                self.alamofireJson() // called for Parsing
                let when = DispatchTime.now() + 5
                DispatchQueue.main.asyncAfter(deadline: when){
                    self.activityIndicator.stopAnimating()
                    if (Global.message != ""){
                    self.nametfielf.text = ""
                    self.EMAIL.text = ""
                    self.PHONE.text = ""
                    self.WEBSITE.text = ""
                    self.MESSAGE.text = ""
                    self.view.makeToast(message: "\(Global.message)",
                                        backgroundColor: nil,
                                        messageColor: UIColor.green)
                        
                    }
                    else {
                        self.view.makeToast(message: "Some error it seems, Please try Again",
                            backgroundColor: nil,
                            messageColor: UIColor.red)
                    }
                }
                }else{
                    self.view.makeToast(message: "No Internet Connection",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
            }
            else{
                if (PHONE.text?.isPhoneNumber)! == false {
                    // message for phone no invalid
                    self.view.makeToast(message: "Phone No is invalid!",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if (EMAIL.text?.isValidEmail())! == false {
                    // message for email invalid
                    self.view.makeToast(message: "Email is Invalid!",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if nametfielf.text?.isValidInput(Input: nametfielf.text!) == false{
                    self.view.makeToast(message: "Name should be 3-18 character",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if WEBSITE.text?.isValidUrl(url: WEBSITE.text!) == false{
                    self.view.makeToast(message: "Please Enter website url in '(http/https)://www.example.com' format",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if MESSAGE.text.isValidUsername(testStr: MESSAGE.text!) == false {
                    self.view.makeToast(message: "Please Enter minimum 20 character for message!",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else {
                    // message for both email and phone number invalid
                    self.view.makeToast(message: "Check your name or phone number or Email or website url!",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                
            }
        }
        
    }
    /// Back Button Function
    ///
    /// - Parameter sender: Any
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    func alamofireJson(){
        
        activityIndicator.startAnimating()
        let urlstring = "http://www.safarimarketingpro.com/contact-us-api.php"
        let parameters = ["fname":"\(nametfielf.text!)","email":"\(EMAIL.text!)","phone":"\(PHONE.text!)","website":"\(WEBSITE.text!)","message":"\(MESSAGE.text!)"]
        Alamofire.request(urlstring, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                if let value = response.result.value {
                   // print("value:",value)
                    Global.final = value as! NSDictionary
                    Global.message = Global.final.value(forKey: "status") as! String
                }
                case .failure(let error):
                    print("error:",error)
        }

        }
        
        
    }
    
    
}
