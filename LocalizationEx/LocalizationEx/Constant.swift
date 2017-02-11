//
//  Constant.swift
//  LocalizationEx
//
//  Created by LaNet on 12/26/16.
//  Copyright © 2016 developer93. All rights reserved.
//

import Foundation
import UIKit


func appDelegate() -> AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

let BASE_CODE = "en"
let ARABIC_CODE = "ar"
let ENGLISH_CODE = "en"
let HINDI_CODE = "hi"
let SPANISH_CODE = "es"
var GUJARATI_CODE = "gu"

extension String{
    func localize() -> String{
        let path = Bundle.main.path(forResource: appDelegate().currentLanguage, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

func setLanguage(langCode: String){
    appDelegate().currentLanguage = langCode
    let defsults = UserDefaults.standard
    defsults.set(appDelegate().currentLanguage, forKey: "AppLanguage")
    defsults.synchronize()
}

