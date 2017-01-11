//
//  Category.swift
//  imageUpload
//
//  Created by LaNet on 1/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

class Category {
    var categoryId: Int?
    var categoryName: String?
    var description: String?
    var categoryImage: String?

    init() {
        self.categoryId = 0
        self.categoryName = "N/A"
        self.description = "N/A"
        self.categoryImage = "N/A"
    }

    func jsonToArray(result: NSMutableArray) -> [Category] {
        var arrCategory = [Category]()
        for i in 0..<result.count {
            if result[i] is NSDictionary {
                let data = result[i] as! NSDictionary
                let objCategory = Category()
                if let categoryId = data["categoryId"] as? Int {
                    objCategory.categoryId = categoryId
                }
                if let categoryName = data["categoryName"] as? String {
                    objCategory.categoryName = categoryName
                }
                if let description = data["description"] as? String {
                    objCategory.description = description
                }
                if let categoryImage = data["categoryImage"] as? String {
                    objCategory.categoryImage = categoryImage
                }
                arrCategory.append(objCategory)
            }
        }
        return arrCategory
    }

}
