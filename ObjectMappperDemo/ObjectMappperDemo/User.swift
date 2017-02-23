//
//  User.swift
//  ObjectMappperDemo
//
//  Created by LaNet on 1/7/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import ObjectMapper

class User: NSObject, Mappable {
    var userId: Int?
    var name: String?
    var userName: String?
    var emailId: String?
    var address: Address?
    var phoneNo: String?
    var website: String?
    var company: Company?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        userId   <- map["id"]
        name     <- map["name"]
        userName <- map["username"]
        emailId  <- map["email"]
        phoneNo  <- map["phone"]
        website  <- map["website"]
        address  <- map["address"]
        company  <- map["company"]
    }

}

class Address: NSObject, Mappable {
    var street: String?
    var suite: String?
    var city: String?
    var zipcode: String?
    var lat: String?
    var lng: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        street   <- map["street"]
        suite    <- map["suite"]
        city     <- map["city"]
        zipcode  <- map["zipcode"]
        lat      <- map["geo.lat"]
        lng      <- map["geo.lng"]
    }

}

class Company: NSObject, Mappable {
    var name: String?
    var catchPhrase: String?
    var bs: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        name        <- map["name"]
        catchPhrase <- map["catchPhrase"]
        bs          <- map["bs"]
    }

}

class Author: NSObject, Mappable {
    var authorId: String?
    var authorName: String?
    var profile: String?
    var emailId: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        authorId        <- map["_id"]
        authorName      <- map["fullName"]
        emailId         <- map["emailId"]
        profile         <- map["profile"]
    }

}
