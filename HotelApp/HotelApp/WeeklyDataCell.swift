//
//  WeeklyDataCell.swift
//  HotelApp
//
//  Created by LaNet on 2/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class WeeklyDataCell: UITableViewCell {
    
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var btnFavorite: UIButton!
    
    @IBOutlet var lblWeeklyDate: UILabel!
    @IBOutlet var lblTodaysTime: UILabel!
    @IBOutlet var lblTitle1: UILabel!
    @IBOutlet var lblTitle2: UILabel!
    @IBOutlet var lblDetails: UILabel!
    @IBOutlet var constImgVWWidth: NSLayoutConstraint!
    
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
            img.layer.cornerRadius = 40
            self.lblWeeklyDate.frame = CGRect(x: 0, y: 10, width: self.lblWeeklyDate.frame.width, height: 20)
            self.lblTitle1.frame = CGRect(x: 0, y: 35, width: self.lblTitle1.frame.width, height: 30)
            self.lblTitle2.frame = CGRect(x: 0, y: 70, width: self.lblTitle2.frame.width, height: 30)
            self.lblDetails.frame = CGRect(x: 0, y: 80, width: self.lblDetails.frame.width, height: self.lblDetails.frame.height)
        }else{
            img.layer.cornerRadius = 25
        }
        img.clipsToBounds = true
    }
    
}
