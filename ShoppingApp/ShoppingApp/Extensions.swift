//
//  Extensions.swift
//  ShoppingApp
//
//  Created by LaNet on 1/12/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String,setImageColor: Bool) {
        let downloadActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        downloadActivityIndicator.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        //        downloadActivityIndicator.color = UIColor.gray
        downloadActivityIndicator.startAnimating()
        self.addSubview(downloadActivityIndicator)
        //    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                downloadActivityIndicator.removeFromSuperview()
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                downloadActivityIndicator.removeFromSuperview()
                if let image = UIImage(data: data!) {
                    if setImageColor {
                        self.image = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                        //                        self.tintColor = getAppColor()
                    }else {
                        self.image = image
                    }
                }else {
                    self.image = UIImage(named: "sorry-image-not-available.png")
                }
            })
        }).resume()
        //          })
    }
    
    func tintImageColor(color: UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
    
}

extension UITextField
{

    func isEmpty()->Bool
    {
        let trimmedString = self.text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if trimmedString!.characters.count == 0
        {
            return true
        }
        return false
    }

}
