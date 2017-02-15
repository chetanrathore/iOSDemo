//
//  RestuarantCell.swift
//  HotelApp
//
//  Created by LaNet on 2/15/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class RestuarantCell: UITableViewCell {
    
    @IBOutlet var imgRestaurant: UIImageView!
    @IBOutlet var btnFavorite: UIButton!
    
    @IBOutlet var lblTitle1: UILabel!
    @IBOutlet var lblTitle2: UILabel!
    @IBOutlet var lblDetails: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var constImgVWWidth: NSLayoutConstraint!
    
    @IBOutlet var constVWHeight: NSLayoutConstraint!
    @IBOutlet var constVWWidth: NSLayoutConstraint!
    
    @IBOutlet var constSpacing: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCellUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellUI() {
        if UIDevice.current.userInterfaceIdiom == .pad{
            constImgVWWidth.constant = 80
            imgRestaurant.layer.cornerRadius = 40
            self.lblTitle1.frame = CGRect(x: 0, y: 1, width: self.lblTitle1.frame.width, height: 30)
            self.lblTitle2.frame = CGRect(x: 0, y: 33, width: self.lblTitle2.frame.width, height: 30)
            self.lblDetails.frame = CGRect(x: 0, y: 65, width: self.lblDetails.frame.width, height: self.lblDetails.frame.height)
            self.lblDateTime.frame = CGRect(x: self.lblDateTime.frame.origin.x, y: self.lblDateTime.frame.origin.y, width: self.lblDateTime.frame.width, height: self.lblDateTime.frame.height)
            self.constVWHeight.constant = 40
            self.constVWWidth.constant = 132
            self.constSpacing.constant = 46
            
        }else{
            imgRestaurant.layer.cornerRadius = 25
        }
        imgRestaurant.clipsToBounds = true
    }
    
}
