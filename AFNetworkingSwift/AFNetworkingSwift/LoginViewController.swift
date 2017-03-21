//
//  LoginViewController.swift
//  AFNetworkingSwift
//
//  Created by LaNet on 3/17/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var img: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tmp = "http://hotel-assist.com/images/loading.gif"
        if let url = NSURL(string: tmp){
            img.image = UIImage.animatedImage(withAnimatedGIFURL: (url as URL))
        }
        //      let request = URLRequest(url: imgUrl as! URL)
        //        img.setImageWith(request, placeholderImage: UIImage(named: "load.gif"), success: { (urlRequest, response,image) in
        //            print("Downloaded")
        //            self.img.image = image
        //        }) { (urlRequest, response, error) in
        //            print(error)
        //        }
        
        var stack = Stack<Int>()
        stack.push(45)
        stack.push(75)
        stack.push(453)
        
        for i in stack.items{
            print(i)
        }
        
        var stack2 = Stack<String>()
        stack2.push("tmp1")
        stack2.push("str2")
        stack2.push("str3")
        
        for i in stack2.items{
            print(i)
        }
        
        var stack3 = Stack<User>()
        
        
        //        img.setImageWith(imgUrl as! URL)
        
        //        let configuration = URLSessionConfiguration.default
        //        let manager = AFURLSessionManager(sessionConfiguration: configuration)
        
        //        manager.downloadTask(with: request, progress: { (progress) in
        //
        //        }, destination: { (url, response) -> URL in
        //
        //        }) { (urlResponse, url, error) in
        //
        //        }
        getUsers()
    }
    
    func getUsers(){
        let manager = AFHTTPSessionManager()
        manager.get("https://jsonplaceholder.typicode.com/users", parameters: [:], progress: { (progress) in
            print("In process")
        }, success: { (task, response) in
            // print(response ?? "Not found")
            let data = User().toArray(jsonData: response)
        }) { (task, error) in
            print("Error")
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        let manager = AFHTTPSessionManager()
        var loginData = [String: String]()
        loginData["email"] = "admin@example.com"
        loginData["password"] = "admin1"
        manager.post("localhost:3000/auth/login", parameters: loginData, progress: { (process) in
        }, success: { (task, response) in
            print(response ?? "Not found")
            let dictionary = response as! NSDictionary
            AppDelegate.token = dictionary.value(forKey: "token") as? String ?? ""
            
        }) { (task, error) in
            print(error)
        }
    }
    
    @IBAction func handleInventory(_ sender: UIButton) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.setValue("Bearer \(AppDelegate.token!)", forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("58b114c59b380e4a8ba42326", forHTTPHeaderField: "rooftopid")
        manager.get("http://lanetteam.com:8085/api/inventories?skip=0&limit=10", parameters: [:], progress: { (progress) in
            print("In process")
        }, success: { (task, response) in
            print(response ?? "Not found")
        }) { (task, error) in
            print("Error")
            print(error)
        }
    }
    
    @IBAction func HandleuploadImage(_ sender: UIButton) {
        let manager = AFHTTPSessionManager()
        var authorData = [String: Any]()
        let img = UIImage(named: "img.jpg")
        let data = UIImageJPEGRepresentation(img!, 50)! as Data
        authorData["emailId"] = "admin121@example.com"
        authorData["gender"] = "Male"
        authorData["fullName"] = "admib123"
        
        manager.post("http://localhost:3000/api/authors", parameters: authorData, constructingBodyWith: { (_ formData: AFMultipartFormData) in
            formData.appendPart(withFileData: data, name: "tmp", fileName: "tmp.jpg", mimeType: "image/jpeg")
            formData.appendPart(withFileData: data, name: "tmp", fileName: "tmp.jpg", mimeType: "image/jpeg")
            formData.appendPart(withFileData: data, name: "tmp", fileName: "tmp.jpg", mimeType: "image/jpeg")
            formData.appendPart(withFileData: data, name: "tmp", fileName: "tmp.jpg", mimeType: "image/jpeg")
        }, progress: { (process) in
            print(process)
        }, success: { (task, response) in
            print(response ?? "Nil")
        }, failure: { (task, error) in
            print(error)
        })
        
    }
    
    
    @IBAction func handleBtnImageVC(_ sender: UIButton) {
        let imageVc = ImagesViewController(nibName: "ImagesViewController", bundle: nil)
        self.navigationController?.pushViewController(imageVc, animated: true)
    }
    
    
}
