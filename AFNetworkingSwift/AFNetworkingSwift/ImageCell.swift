//
//  ImageCell.swift
//  AFNetworkingSwift
//
//  Created by LaNet on 3/18/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet var img: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
