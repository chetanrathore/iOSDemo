//
//  ImageLoadingVC.swift
//  ObjectMappperDemo
//
//  Created by LaNet on 2/23/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import ObjectMapper

class ImageLoadingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var author = [Author]()
    var pageNo: Int = 0
    var totalPages: Int = 0
    @IBOutlet var tblAuthor: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblAuthor.dataSource = self
        tblAuthor.delegate = self
        tblAuthor.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        getAuthor()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getAuthor() {
        APIService.sharedInstance.sendRequest(method: "GET", postedData: [:], apiMethod: apiAuthor+String(pageNo), completion: { (resultData, isError, isConnectionError) in
            print(resultData)
            let data = resultData as! NSDictionary
            let authord = data.value(forKey: "author")
            self.pageNo = data.value(forKey: "pageNo") as! Int
            self.totalPages = data.value(forKey: "totalPage") as! Int
            var authorData = [Author]()
            authorData = Mapper<Author>().mapArray(JSONArray: authord as! [[String: Any]])!
            self.author += authorData
            self.tblAuthor.reloadData()
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return author.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let author = self.author[indexPath.row]
        if author.profile != nil {
        let url = baseUrl + "/author/" + author.profile!
            cell.img.imageFromServerURL(urlString: url)
        }
        if indexPath.row == (self.author.count - 1) {
            self.pageNo += 1
            if pageNo < totalPages {
                self.getAuthor()
            }
        }
        return cell
    }

}

extension UIImageView {

    public func imageFromServerURL(urlString: String) {
        let downloadActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        downloadActivityIndicator.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        downloadActivityIndicator.startAnimating()
        self.addSubview(downloadActivityIndicator)
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                downloadActivityIndicator.removeFromSuperview()
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                downloadActivityIndicator.removeFromSuperview()
                if let image = UIImage(data: data!) {
                    self.image = image
                }
            })
        }).resume()
    }

}
