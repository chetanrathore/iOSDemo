//
//  RegistrationViewController.swift
//  ShoppingApp
//
//  Created by LaNet on 1/12/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var lblSignUp: UILabel!
    @IBOutlet var txtFullname: UITextField!
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnLoginNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInteface()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInteface(){
        self.navigationController?.navigationBar.isHidden = true
        txtFullname = appTextField(textField: txtFullname)
        txtUsername = appTextField(textField: txtUsername)
        txtPassword = appTextField(textField: txtPassword)
        btnRegister = appButton(appButton: btnRegister, backColor: getAppColor(), textColor: getWhiteColor(), radius: true)
        btnLoginNow.setTitleColor(getAppColor(), for: .normal)
        txtFullname.delegate = self
        txtUsername.delegate = self
        txtPassword.delegate = self
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        txtFullname.resignFirstResponder()
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
        
        let strFullName = txtFullname.text!
        let strUserName = txtUsername.text!
        let strPassword = txtPassword.text!
        
        if (strFullName.isEmpty || strUserName.isEmpty || strPassword.isEmpty) {
            displayAlertMessage(alertMessage: "All field must be required.")
        }else if(!isValidEmail(strEmail: strUserName)) {
            displayAlertMessage(alertMessage: "Invalid email address.")
        }else if(!isValidPassword(strPassword: strPassword)) {
            displayAlertMessage(alertMessage: "Password must contain at least 8 characters")
        }else {
            var userData = [String: Any]();
            userData["fullName"] = strFullName
            userData["emailId"] = strUserName
            userData["password"] = strPassword
            ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: API_REGISTRATION, Str_Request_Method: "POST", Request_parameter: userData, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
            }, response_Dictionary: { (result) in
                DispatchQueue.main.async {
                    var message = ""
                    if result.object(forKey: "message") != nil {
                        message = (result.object(forKey: "message") as? String)!
                    }
                    if result.object(forKey: "status") != nil {
                        let status = result.object(forKey: "status") as? Int
                        if status == 1 {
                            ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: API_LOGIN, Str_Request_Method: "POST", Request_parameter: userData, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
                            }, response_Dictionary: { (result) in
                                print(result)
                                let objUser = User().dictionaryToObject(data: result)
                                setUserDefaults(user: objUser)
                                let productVC = ProductViewController(nibName: "ProductViewController", bundle: nil)
                                self.navigationController?.pushViewController(productVC, animated: true)
                            }, response_Array: { (result) in
                            })
                            
                        }else {
                            self.displayAlertMessage(alertMessage: message)
                        }
                    }
                }
            }, response_Array: { (result) in
            })
        }
    }
    
    @IBAction func btnLoginNow(_ sender: UIButton) {
        let viewControllers = self.navigationController?.viewControllers
        for vc in viewControllers!{
            if vc.isKind(of: LoginViewController.self){
                self.navigationController!.popToViewController(vc, animated: true)
                return
            }
        }
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func displayAlertMessage(title: String = "Oops!",alertMessage:String) {
        let alert = UIAlertController(title: title, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
