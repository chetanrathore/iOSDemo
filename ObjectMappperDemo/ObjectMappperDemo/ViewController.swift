//
//  ViewController.swift
//  ObjectMappperDemo
//
//  Created by LaNet on 1/7/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import ObjectMapper

class ViewController: UIViewController {

    var users = [User]()
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //  getData()
        getProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getData() {
        APIService.sharedInstance.sendRequest(method: "GET", postedData: [:], apiMethod: ApiTest, completion: { (resultData, isError, isConnectionError) in
            self.users = Mapper<User>().mapArray(JSONArray: resultData as! [[String: Any]])!
        })
    }

    //        let url = URL(string: API_STYLE_AGAIN)
    //        let task = URLSession.shared.dataTask(with: url!) { (data, res, err) in
    //            if err != nil {
    //                print (err!)
    //            }
    //            do{
    //                if let responseJSON = try JSONSerialization.jsonObject (with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableDictionary {
    //
    //                    let result = responseJSON.value(forKey: "data")
    //
    //                    let customerArray = Mapper<Product>().mapArray(JSONArray: responseJSON as! [[String: Any]])
    //
    //                     print(customerArray!)
    //                }
    //
    //            }catch{
    //            }
    //
    //        }
    //        task.resume()

    func getProducts() {
        APIService.sharedInstance.sendRequest(method: "GET", postedData: [:], apiMethod: ApiStyleAgain, completion: { (resultData, isError, isConnectionError) in
            let data = (resultData as! NSDictionary).value(forKey: "data")
            self.products =  Mapper<Product>().mapArray(JSONArray: data as! [[String: Any]])!
        })
    }

}
