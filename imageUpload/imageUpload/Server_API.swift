//
//  Server_API.swift
//  imageUpload
//
//  Created by LaNet on 1/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import Foundation
import UIKit

class server_API {
    
    static let sharedObject = server_API()
    
    let Base_url = "http://localhost:3000/api/"
    
    let int_gone_msg = "You are disconnected from the internet.".capitalized
    
    func requestFor_NSMutableDictionary(Str_Request_Url:String , Request_parameter:[String: Any]? , Request_parameter_Images:[String: UIImage]? ,isTokenEmbeded:Bool, status: @escaping (_ result: Calling_Status) -> Void , response_Dictionary: @escaping (_ results: NSMutableDictionary) -> Void) {
        
        let myurl = NSURL(string: "\(Base_url)\(Str_Request_Url)")
        let obj_of_status = Calling_Status(Status: false, Message: "Request Failed",Request_Url: "\(Base_url)\(Str_Request_Url)")
        let req = NSMutableURLRequest(url: myurl! as URL)
        if (isTokenEmbeded == false) {
            
        }else{
            //  req.setValue(AppDelegate.token , forHTTPHeaderField: "Authorization")
        }
        var QuaryString = ""
        
        if Request_parameter_Images != nil {
            req.httpMethod = "POST"
            let boundary = generateBoundaryString()
            req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            req.httpBody = self.createBodyWithParameter(parameters: Request_parameter, imageData: Request_parameter_Images!, boundary: boundary) as Data
        }
        else {
            if Request_parameter  != nil {
                req.httpMethod = "POST"
                do {
                    req.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    let jsonData = try JSONSerialization.data(withJSONObject: Request_parameter!, options: .prettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    //  let strJson = NSString(data: jsonData, encoding: String.Encoding.ascii.rawValue)
                    req.httpBody = jsonData
                }catch {
                    for (key, value) in Request_parameter!
                    {
                        QuaryString = "\(QuaryString)\(key)=\(value)&"
                    }
                    req.httpBody = QuaryString.data(using: String.Encoding.utf8)
                }
            }
        }
        let task = URLSession.shared.dataTask(with: req as URLRequest) {
            data,res,err in
            if(err != nil) {
                if err?._code == -1004{
                    obj_of_status.Message = "Could't create connection with the server.".capitalized
                    status(obj_of_status)
                    return
                }
                obj_of_status.Message = "\(err)"
                status(obj_of_status)
                return
            }
            do {
                if let json: NSMutableDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableDictionary {
                    obj_of_status.Message = "Success get Response.".capitalized
                    status(obj_of_status)
                    response_Dictionary(json)
                    return
                }
            } catch let error as NSError {
                obj_of_status.Message = "\(error.localizedDescription)"
                status(obj_of_status)
                return
            }
        }
        task.resume()
    }
    
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    private func createBodyWithParameter(parameters: [String: Any]?, imageData: [String: UIImage], boundary: String) -> NSData {
        let body = NSMutableData();
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                body.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
        }
        for (_,img) in imageData {
            var i = 1
            let mimetype = "image/jpg"
            body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
            let name = "img\(i).jpg"
            body.append("Content-Disposition: form-data; name=\"categoryImg\"; filename=\"\(name)\"\r\n".data(using: String.Encoding.utf8)!)
            body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
            let imageData = UIImageJPEGRepresentation(img, 1)
            body.append(imageData!)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
            i += 1
        }
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        
        return body
    }
}

class Calling_Status{
    var Status:Bool
    var Message:String
    var Request_Url:String
    init(Status:Bool,Message:String,Request_Url:String){
        self.Status = Status
        self.Message = Message
        self.Request_Url = Request_Url
    }
}

