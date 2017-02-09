//
//  User.swift
//  ShoppingApp
//
//  Created by LaNet on 1/12/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

class User{
    var userId: Int
    var fullName: String
    var userName: String
    var password: String
    var message: String
    var status: Int
    
    init(){
        self.userId = 0
        self.fullName = STR_EMPTY
        self.password = STR_EMPTY
        self.userName = STR_EMPTY
        self.status = 0
        self.message = STR_EMPTY
    }

    func dictionaryToObject(data: NSMutableDictionary) -> User{
        let objUser = User()
        if data.object(forKey: "message") != nil {
            objUser.message = (data.object(forKey: "message") as? String)!
        }
        if data.object(forKey: "userId") != nil {
            objUser.userId = (data.object(forKey: "userId") as? Int)!
        }
        if data.object(forKey: "fullName") != nil {
            objUser.message = (data.object(forKey: "fullName") as? String)!
        }
        if data.object(forKey: "emailId") != nil {
            objUser.message = (data.object(forKey: "emailId") as? String)!
        }
        return objUser
    }
    
}

