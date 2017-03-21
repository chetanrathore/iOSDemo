//
//  Extension.swift
//  AFNetworkingSwift
//
//  Created by LaNet on 3/20/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

extension UIImageView{
    
    func setImage(urlStr: String){
//        let tmp = "https://raw.githubusercontent.com/Flipboard/FLAnimatedImage/master/images/flanimatedimage-demo-player.gif"
        if let url = NSURL(string: urlStr){
            self.sd_setImage(with: url as URL, placeholderImage: UIImage(named: "load.gif"), options: SDWebImageOptions.progressiveDownload) { (image, error, SDImageCacheType, url) in
                if error == nil{
                    self.image = image
//                    self.image = resizeImage(image: image!, targetSize: CGSize(width: 30, height: 30))
                }else{
                    print("Fail")
                }
            }
        }
    }
}


func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
}
