//
//  CategoryViewCell.swift
//  imageUpload
//
//  Created by LaNet on 1/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class CategoryViewCell: UITableViewCell {

    @IBOutlet var imgCategory: UIImageView!
    @IBOutlet var lblCategoryName: UILabel!
    @IBOutlet var lblDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
