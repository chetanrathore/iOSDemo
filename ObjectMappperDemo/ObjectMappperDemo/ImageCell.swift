//
//  ImageCell.swift
//  ObjectMappperDemo
//
//  Created by LaNet on 2/23/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
