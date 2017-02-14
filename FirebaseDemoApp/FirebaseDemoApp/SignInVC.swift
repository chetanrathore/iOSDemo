//
//  SignInVC.swift
//  FirebaseDemoApp
//
//  Created by LaNet on 2/13/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.text = ""
        txtPassword.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        let email = txtEmail.text!
        let pwd = txtPassword.text!
        FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
            if error != nil{
                if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
                    switch errCode {
                    case .errorCodeUserNotFound:
                        self.showAlert("User account not found. Try registering")
                    case .errorCodeWrongPassword:
                        self.showAlert("Incorrect username/password combination")
                    default:
                        self.showAlert("Error: \(error?.localizedDescription)")
                    }
                }
            }else {
                let dataVC = DataVC(nibName: "DataVC", bundle: nil)
                self.navigationController?.pushViewController(dataVC, animated: true)
            }
        })
    }
    
    @IBAction func btnRegister(_ sender: UIButton) {
        let signUpVC = SignUpVC(nibName: "SignUpVC", bundle: nil)
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func showAlert(_ str: String) {
        let alert = UIAlertController(title: "", message: str, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
