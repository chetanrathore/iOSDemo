//
//  Album.swift
//  AFNetworkingSwift
//
//  Created by LaNet on 3/20/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation

class Photos{
    
    private var photos = [Photos]()
    var albumId: Int = 0
    var id: Int = 0
    var title: String = ""
    var url: String = ""
    var thumbnailUrl:String = ""
    
    func toPhotos(jsonData: Any) -> [Photos] {
        let jsonArr = jsonData as! NSArray
        for data in jsonArr{
            let photos = data as! NSDictionary
            let objPhotos = Photos()
            if let albumId = photos.value(forKey: "albumId") as? Int{
                objPhotos.albumId = albumId
            }
            if let id = photos.value(forKey: "id") as? Int{
                objPhotos.id = id
            }
            if let title = photos.value(forKey: "title") as? String{
                objPhotos.title = title
            }
            if let url = photos.value(forKey: "url") as? String{
                objPhotos.url = url
            }
            if let thumbnailUrl = photos.value(forKey: "thumbnailUrl") as? String{
                objPhotos.thumbnailUrl = thumbnailUrl
            }
            self.photos.append(objPhotos)
        }
        return self.photos
    }
    
}
