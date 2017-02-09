//
//  AppDesign.swift
//  StyleAgainApp
//
//  Created by Devloper30 on 05/11/16.
//  Copyright © 2016 Sonal. All rights reserved.
//

import Foundation
import UIKit

func getFontColor() -> UIColor{
    return appUIColorFromRGB(rgbValue: FONT_COLOR, alpha: 1)
}

func  getInfoFontColor() -> UIColor{
    return appUIColorFromRGB(rgbValue: INFO_FONT_COLOR, alpha: 1)
}

func getAppColor() -> UIColor{
    let userDefaults : UserDefaults = UserDefaults.standard
    if(userDefaults.object(forKey: "AppColor") != nil){
        let appColor = userDefaults.object(forKey: "AppColor") as! UInt
        return appUIColorFromRGB(rgbValue: appColor, alpha: 1)
    }else{
        return appUIColorFromRGB(rgbValue: APP_COLOR, alpha: 1)
    }
}

func getWhiteColor() -> UIColor{
    return UIColor.white
}

func getBlackColor() -> UIColor{
    return UIColor.black
}

func getBackgroundColor() -> UIColor {
    return appUIColorFromRGB(rgbValue: BACK_COLOR, alpha: 1)
}

func appFontRegular(x:CGFloat) -> UIFont {
    return UIFont(name: "OpenSans", size: x)!
}

func appFontSemiBold(x:CGFloat) -> UIFont {
    return UIFont(name: "OpenSans-SemiBold", size: x)!
}

//Controller design

func appTextField(textField:UITextField) -> UITextField{
    textField.backgroundColor = appUIColorFromRGB(rgbValue: BACK_COLOR, alpha: 1)
    textField.layer.borderColor = nil
    return textField
}

func appButton(appButton:UIButton,backColor:UIColor,textColor:UIColor,radius:Bool) -> UIButton {
    
    appButton.backgroundColor = backColor
    appButton.setTitleColor(textColor, for: UIControlState.normal)
    if(radius)
    {
        appButton.layer.cornerRadius = 20
    }
    return appButton
}

func appUIColorFromRGB(rgbValue: UInt,alpha:Double) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(alpha)
    )
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}


