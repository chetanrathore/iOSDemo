//
//  SignInVC.swift
//  HotelApp
//
//  Created by LaNet on 2/9/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var btnSignIn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SignIn"
        self.btnSignIn.layer.cornerRadius = 5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleBtnSignIn(_ sender: UIButton) {
        
    }
    
}
