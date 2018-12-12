//
//  QuoteViewController.swift
//  SafariMarketingPro
//
//  Created by Sagar on 17/11/18.
//  Copyright © 2018 Sagar. All rights reserved.
//

import UIKit
import MessageUI
import NVActivityIndicatorView
import Alamofire
class QuoteViewController: UIViewController , UITextViewDelegate , UITextFieldDelegate, MFMailComposeViewControllerDelegate{
    struct Global {
        static var responseMsg = String()
        static var final = NSDictionary()
        static var message = String()
    }
    @IBOutlet weak var namelbl: UITextField!
    
    @IBOutlet weak var weblbl: UITextField!
    @IBOutlet weak var phonelbl: UITextField!
    @IBOutlet weak var emaillbl: UITextField!
    @IBOutlet weak var txtVw: UITextView!
    
    @IBOutlet weak var callvw: UIView!
    
    @IBOutlet weak var mailvw: UIView!
    @IBOutlet weak var nextvw: UIView!
    
    @IBOutlet weak var flbl: UILabel!
    @IBOutlet weak var slbl: UILabel!
    @IBOutlet weak var tlbl: UILabel!
    let phone1 = "+91-700-873-8714"
    var activityIndicator :NVActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: CGSize(width: 60,height: 60)
        )
        activityIndicator = NVActivityIndicatorView(frame: rect,  type: NVActivityIndicatorType(rawValue: 3), color: UIColor.red)
        activityIndicator.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        self.view.addSubview(activityIndicator)
        //Label
        
        let myColor = UIColor.lightGray
        
        namelbl.layer.borderColor = myColor.cgColor
        emaillbl.layer.borderColor = myColor.cgColor
        phonelbl.layer.borderColor = myColor.cgColor
        weblbl.layer.borderColor = myColor.cgColor
        txtVw.layer.borderColor = myColor.cgColor
        
        namelbl.layer.cornerRadius = 15.0
        emaillbl.layer.cornerRadius = 15.0
        phonelbl.layer.cornerRadius = 15.0
        weblbl.layer.cornerRadius = 15.0
        namelbl.layer.borderWidth = 2.0
        emaillbl.layer.borderWidth = 2.0
        phonelbl.layer.borderWidth = 2.0
        weblbl.layer.borderWidth = 2.0
        txtVw.layer.borderWidth = 2.0
        txtVw.layer.cornerRadius = 15.0
        // NAME
        namelbl.delegate = self
        namelbl.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "user")
        imageView.image = image
        namelbl.leftView = imageView
        
        // EMAIL
        emaillbl.delegate = self
        emaillbl.leftViewMode = .always
        let imageView1 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image1 = UIImage(named: "emee")
        imageView1.image = image1
        emaillbl.leftView = imageView1
        
        
        // PHONE
        phonelbl.delegate = self
        phonelbl.leftViewMode = .always
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image2 = UIImage(named: "cell")
        imageView2.image = image2
        phonelbl.leftView = imageView2
        
        // WEBSITE
        weblbl.delegate = self
        weblbl.leftViewMode = .always
        let imageView3 = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image3 = UIImage(named: "website")
        imageView3.image = image3
        weblbl.leftView = imageView3
    
        self.hideKeyboardWhenTappedAround()
        
        
        txtVw.text = "Write Your Message Here"
        txtVw.textColor = UIColor.lightGray
        txtVw.delegate = self
        flbl.text = ">  An email and phone call from us."
        flbl.lineBreakMode = .byWordWrapping
        flbl.numberOfLines = 0
        slbl.text = ">  A time & cost estimation."
        tlbl.text = ">  An in-person meeting."
        nextvw.layer.borderWidth = 1.0
        nextvw.layer.borderColor = UIColor.green.cgColor
        callvw.layer.borderWidth = 1.0
        callvw.layer.borderColor = UIColor.green.cgColor
        mailvw.layer.borderWidth = 1.0
        mailvw.layer.borderColor = UIColor.green.cgColor
        

    }
    func textViewDidBeginEditing(_ textView: UITextView) {
       
        if txtVw.textColor == UIColor.lightGray {
            txtVw.text = nil
            txtVw.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtVw.text.isEmpty {
            txtVw.text = "Write Your Message Here"
            txtVw.textColor = UIColor.lightGray
        }
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
    /// Mail Button Function
    ///
    /// - Parameter sender: Any
    @IBAction func mail(_ sender: Any) {
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
            self.view.makeToast(message: "Please Check Your Internet Connection!",
                                backgroundColor: nil,
                                messageColor: UIColor.red)
        }
    }
    
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
    
    /// Phone Button Function
    ///
    /// - Parameter sender: Any
    @IBAction func phone(_ sender: Any) {
        if let url = URL(string: "tel://\(phone1)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    /// Back Button Function
    ///
    /// - Parameter sender: Any
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /// Function for Json Parsing
    func alamofireJson(){
        
        activityIndicator.startAnimating()
        let urlstring = "http://www.safarimarketingpro.com/get-a-quote-api.php"
        let parameters = ["fname":"\(namelbl.text!)","email":"\(emaillbl.text!)","phone":"\(phonelbl.text!)","website":"\(weblbl.text!)","message":"\(txtVw.text!)"]
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
    
    
    /// Quote Submit button function to server side
    ///
    /// - Parameter sender: Any
    @IBAction func clickQuote(_ sender: Any) {
        if (namelbl.text?.isEmpty)! || (emaillbl.text?.isEmpty)! || (phonelbl.text?.isEmpty)! || (weblbl.text?.isEmpty)!
        {
            //Provide a popup as alert
            print("Check Credentials")
            if (namelbl.text?.isEmpty)! {
                self.view.makeToast(message: "Please Check Your Name",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                namelbl.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
            else if (emaillbl.text?.isEmpty)!{
                self.view.makeToast(message: "Please Check Your email",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                emaillbl.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
            else if (phonelbl.text?.isEmpty)!{
                self.view.makeToast(message: "Check Your Phone Number",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                phonelbl.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
            else{
                self.view.makeToast(message: "Check Your website",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                weblbl.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
        }
        else {
            
            if (emaillbl.text?.isValidEmail())! && (phonelbl.text?.isPhoneNumber)! && ((namelbl.text?.isValidInput(Input: namelbl.text!) != false)) && ((weblbl.text?.isValidUrl(url: weblbl.text!)) != false) && (txtVw.text.isValidUsername(testStr: txtVw.text!) != false){
                self.view.makeToast(message: "All ok go for Parsing",
                                    backgroundColor: nil,
                                    messageColor: UIColor.red)
                self.alamofireJson()
                let when = DispatchTime.now() + 5
                DispatchQueue.main.asyncAfter(deadline: when){
                    self.activityIndicator.stopAnimating()
                    if (Global.message != ""){
                        self.namelbl.text = ""
                        self.emaillbl.text = ""
                        self.phonelbl.text = ""
                        self.weblbl.text = ""
                        self.txtVw.text = ""
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
            }
            else{
                if (phonelbl.text?.isPhoneNumber)! == false {
                    // message for phone no invalid
                    self.view.makeToast(message: "Phone no invalid!",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if (namelbl.text?.isValidInput(Input: namelbl.text!)) == false {
                    self.view.makeToast(message: "Name must be 3 character",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if weblbl.text?.isValidUrl(url: weblbl.text!) == false{
                    self.view.makeToast(message: "Please Enter website url in 'http/https://www.example.com' format",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if (emaillbl.text?.isValidEmail())! == false {
                    // message for email invalid
                    self.view.makeToast(message: "Email is Invalid!",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else if txtVw.text.isValidUsername(testStr: txtVw.text!) == false {
                    self.view.makeToast(message: "Please Enter minimum 20 character for message",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                else {
                    // message for both email and phone number invalid
                    self.view.makeToast(message: "Check both phone number and Email provided!",
                                        backgroundColor: nil,
                                        messageColor: UIColor.red)
                }
                
            }
            
          
        }
        
        
    }
}
