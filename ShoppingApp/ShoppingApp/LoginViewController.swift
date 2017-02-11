//
//  LoginViewController.swift
//  ShoppingApp
//
//  Created by LaNet on 1/12/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var lblSignIn: UILabel!
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnRegisterNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInteface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setInteface(){
        self.navigationController?.navigationBar.isHidden = true
        txtUsername = appTextField(textField: txtUsername)
        txtPassword = appTextField(textField: txtPassword)
        btnLogin = appButton(appButton: btnLogin, backColor: getAppColor(), textColor: getWhiteColor(), radius: true)
        btnRegisterNow.setTitleColor(getAppColor(), for: .normal)
        txtUsername.delegate = self
        txtPassword.delegate = self
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
        let strUserName = txtUsername.text!
        let strPassword = txtPassword.text!

        if (strUserName.isEmpty || strPassword.isEmpty) {
            displayAlertMessage(alertMessage: "Email id and password must be required.")
        }else if(!isValidEmail(strEmail: strUserName)) {
            displayAlertMessage(alertMessage: "Invalid email address.")
        }else if(!isValidPassword(strPassword: strPassword)) {
            displayAlertMessage(alertMessage: "Password must contain at least 8 characters")
        }else {
            var userData = [String: Any]();
            userData["emailId"] = strUserName
            userData["password"] = strPassword
            ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: API_LOGIN, Str_Request_Method: "POST", Request_parameter: userData, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
            }, response_Dictionary: { (result) in
                DispatchQueue.main.async {
                    var message = ""
                    if result.object(forKey: "message") != nil {
                        message = (result.object(forKey: "message") as? String)!
                    }
                    if result.object(forKey: "status") != nil {
                        let status = result.object(forKey: "status") as? Int
                        if status == 1 {
                            let objUser = User().dictionaryToObject(data: result)
                            setUserDefaults(user: objUser)
                            let productVC = ProductViewController(nibName: "ProductViewController", bundle: nil)
                            self.navigationController?.pushViewController(productVC, animated: true)
                        }else {
                            self.displayAlertMessage(alertMessage: message)
                        }
                    }
                }
            }, response_Array: { (result) in
            })
        }
    }
    
    @IBAction func btnRegisterNow(_ sender: UIButton) {
        let registrationVC = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    func displayAlertMessage(title: String = "Oops!",alertMessage:String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
