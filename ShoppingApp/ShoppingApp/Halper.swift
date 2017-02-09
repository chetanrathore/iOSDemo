//
//  Halper.swift
//  ShoppingApp
//
//  Created by LaNet on 1/12/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

func isValidEmail(strEmail : String) ->  Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: strEmail)
}

func isValidPassword(strPassword : String) -> Bool
{
    let totalChar = strPassword.characters.count
    return totalChar > 8
}

func isValidText(strText : String) ->  Bool
{
    let textRegEx = "[A-Za-z -]+"
    let textTest = NSPredicate(format:"SELF MATCHES %@", textRegEx)
    return textTest.evaluate(with: strText)
}

func userAlreadyLoggedIn() -> Bool {
    let userDefaults : UserDefaults = UserDefaults.standard
    if (userDefaults.object(forKey: "userId") != nil) {
        return true
    }
    return false
}

func setUserDefaults(user: User) {
    let userDefaults : UserDefaults = UserDefaults.standard
    userDefaults.set(user.userId, forKey: "userId")
    userDefaults.set(user.userName, forKey: "userName")
    userDefaults.set(user.fullName, forKey: "fullName")
}
