//
//  Item.swift
//  FirebaseDemoApp
//
//  Created by LaNet on 2/13/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Item{
    var ref: FIRDatabaseReference!
    var title: String?
    
    init(snapShot: FIRDataSnapshot) {
        ref = snapShot.ref
        let data = snapShot.value as! Dictionary<String, String>
        title = data["title"]! as String
    }
    
}
