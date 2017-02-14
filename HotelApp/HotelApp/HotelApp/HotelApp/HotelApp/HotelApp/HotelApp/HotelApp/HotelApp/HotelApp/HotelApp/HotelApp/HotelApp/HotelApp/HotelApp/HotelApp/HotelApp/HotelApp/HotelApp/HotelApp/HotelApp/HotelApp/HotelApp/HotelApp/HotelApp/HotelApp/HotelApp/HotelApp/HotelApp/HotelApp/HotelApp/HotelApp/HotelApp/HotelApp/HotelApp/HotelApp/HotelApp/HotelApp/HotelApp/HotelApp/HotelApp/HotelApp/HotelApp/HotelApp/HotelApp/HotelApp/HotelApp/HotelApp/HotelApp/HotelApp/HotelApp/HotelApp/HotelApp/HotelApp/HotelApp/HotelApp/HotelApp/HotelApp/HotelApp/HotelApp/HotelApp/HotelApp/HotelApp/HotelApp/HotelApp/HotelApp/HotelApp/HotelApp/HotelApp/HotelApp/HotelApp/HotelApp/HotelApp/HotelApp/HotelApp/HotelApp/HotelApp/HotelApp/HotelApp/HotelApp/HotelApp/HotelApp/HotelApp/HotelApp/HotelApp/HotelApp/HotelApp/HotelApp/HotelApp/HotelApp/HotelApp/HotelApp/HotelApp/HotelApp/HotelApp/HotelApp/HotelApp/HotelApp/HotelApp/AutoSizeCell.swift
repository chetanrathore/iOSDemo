//
//  AutoSizeCell.swift
//  HotelApp
//
//  Created by LaNet on 2/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class AutoSizeCell: UITableViewCell {
    
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblAddress: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
