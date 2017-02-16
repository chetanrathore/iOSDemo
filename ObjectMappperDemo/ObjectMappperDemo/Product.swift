//
//  Product.swift
//  ObjectMappperDemo
//
//  Created by LaNet on 1/7/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import ObjectMapper

let transformInt = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
    // transform value from String? to Int?
    return Int(value!)
}, toJSON: { (value: Int?) -> String? in
    // transform value from Int? to String?
    if let value = value {
        return String(value)
    }
    return nil
})

let transformFloat = TransformOf<Float, String>(fromJSON: { (value: String?) -> Float? in
    // transform value from String? to Int?
    return Float(value!)
}, toJSON: { (value: Float?) -> String? in
    // transform value from Int? to String?
    if let value = value {
        return String(value)
    }
    return nil
})

class Product: NSObject, Mappable {
    var categoryId: Int?
    var categoryName: String?
    var categoryImage: String?
    var products: [ProductDetails]?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        categoryId      <- (map["Id"], transformInt)
        categoryName    <- map["Name"]
        categoryImage   <- map["Imgurl"]
        products        <- map["Products"]
    }

}

class ProductDetails: NSObject, Mappable {
    var productId: Int?
    var productName: String?
    var productImage: String?
    var retailPrice: Float?
    var sellingPrice: Float?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        productId       <- (map["product details.entity_id"], transformInt)
        productName     <- map["product details.name"]
        productImage    <- map["product details.image"]
        retailPrice     <- map["product details.price"]
        sellingPrice    <- map["product details.special_price"]
    }

}

class LoginUser {
    var userId: Int?
    var topSize: Int?
    var bottomSize: Int?
    var shoesSize: Int?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        userId      <- map["stuserid"]
        topSize     <- map["top"]
        bottomSize  <- map["bottom"]
        shoesSize   <- map["foot"]
    }

}

class Category: NSObject, Mappable {
    var categoryId: String?
    var categoryName: String?
    var cDescription: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        categoryId      <- map["_id"]
        categoryName    <- map["categoryName"]
        cDescription    <- map["description"]
    }

}
