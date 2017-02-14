//
//  SignInVC.swift
//  FirebaseDemoApp
//
//  Created by LaNet on 2/13/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
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
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        let email = txtEmail.text!
        let pwd = txtPassword.text!
        
        FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
            if error != nil{
                self.showAlert("Fail to create an account.")
            }else {
                let signInVC = SignInVC(nibName: "SignInVC", bundle: nil)
                self.navigationController?.pushViewController(signInVC, animated: true)
            }
        })
    }
    
    @IBAction func btnSignIn(_ sender: UIButton) {
        let signInVC = SignInVC(nibName: "SignInVC", bundle: nil)
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    func showAlert(_ str: String) {
        let alert = UIAlertController(title: "", message: str, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
