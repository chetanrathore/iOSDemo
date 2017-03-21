//
//  User.swift
//  AFNetworkingSwift
//
//  Created by LaNet on 3/18/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

struct Stack<T> {
    var items = [T]()
    mutating func push(_ item: T) {
        items.append(item)
    }
}


class Map<T>{
    let arr = [T]()
    
    func toArray(json: Any?){
    }

}

func bindData<T>(dic: NSDictionary,str: String, type: inout T){
    if let val: T = dic[str] as? T{
        type = val
    }
}

class User{
    
    private var userData = [User]()
    
    var id: Int = 0
    var name: String = ""
    var username: String = ""
    var email: String = ""
    var address: Addresss = Addresss()
    var phone: String = ""
    var website: String = ""
    var company: Company = Company()
    
    init() {
    }
    
    func toArray(jsonData: Any) -> [User]{
        let jsonArr = jsonData as! NSArray
        for data in jsonArr{
            let objUser = User()
            let obj = data as! NSDictionary
            bindData(dic: obj, str: "id", type: &objUser.id)
            bindData(dic: obj, str: "name", type: &objUser.name)
            bindData(dic: obj, str: "username", type: &objUser.username)
            bindData(dic: obj, str: "email", type: &objUser.email)
            bindData(dic: obj, str: "phone", type: &objUser.phone)
            bindData(dic: obj, str: "website", type: &objUser.website)
            
//            if let name = obj.value(forKey: "name") as? String{
//                objUser.name = name
//            }
//            if let username = obj.value(forKey: "username") as? String{
//                objUser.username = username
//            }
//            if let email = obj.value(forKey: "email") as? String{
//                objUser.email = email
//            }
//            if let phone = obj.value(forKey: "phone") as? String{
//                objUser.phone = phone
//            }
//            if let website = obj.value(forKey: "website") as? String{
//                objUser.website = website
//            }
            if let address = obj.value(forKey: "address") as? NSDictionary{
                objUser.address = Addresss().toAddress(address: address)
            }
            if let company = obj.value(forKey: "company") as? NSDictionary{
                objUser.company = Company().toCompany(company: company)
            }
            userData.append(objUser)
        }
        return userData
    }

}

class Addresss{
    
    var street: String = ""
    var suite: String = ""
    var city: String = ""
    var zipcode: String = ""
    var geo: Geo = Geo()
    
    func toAddress(address: NSDictionary) -> Addresss {
        let objAddress = Addresss()
        if let street = address.value(forKey: "street") as? String{
            objAddress.street = street
        }
        if let suite = address.value(forKey: "suite") as? String{
            objAddress.suite = suite
        }
        if let city = address.value(forKey: "city") as? String{
            objAddress.city = city
        }
        if let zipcode = address.value(forKey: "zipcode") as? String{
            objAddress.zipcode = zipcode
        }
        if let geo = address.value(forKey: "geo") as? NSDictionary{
            objAddress.geo = Geo().toGeo(geo: geo)
        }
        return objAddress
    }
    
}

class Geo{
    var lat: String = ""
    var lng: String = ""
    func toGeo(geo: NSDictionary) -> Geo {
        let objGeo = Geo()
        if let lat = geo.value(forKey: "lat") as? String{
            objGeo.lat = lat
        }
        if let lng = geo.value(forKey: "lng") as? String{
            objGeo.lng = lng
        }
        return objGeo
    }
    
}

class Company{
    var name: String = ""
    var catchPhrase: String = ""
    var bs: String = ""
    
    func toCompany(company: NSDictionary) -> Company {
        let objCompany = Company()
        if let name = company.value(forKey: "name") as? String{
            objCompany.name = name
        }
        if let catchPhrase = company.value(forKey: "catchPhrase") as? String{
            objCompany.catchPhrase = catchPhrase
        }
        if let bs = company.value(forKey: "bs") as? String{
            objCompany.bs = bs
        }
        return objCompany
    }
    
}



