//
//  ImageCachingVC.swift
//  HotelApp
//
//  Created by LaNet on 2/21/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ImageCachingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblData: UITableView!
    var refresh: UIRefreshControl!
    var arrData:[AnyObject]!
    var task: URLSessionDownloadTask!
    var session:URLSession!
    var cache:NSCache<AnyObject, AnyObject>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblData.dataSource = self
        tblData.delegate = self
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        self.arrData = []
        self.cache = NSCache()
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.getData), for: .valueChanged)
        
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        let url: URL! = URL(string: "https://itunes.apple.com/search?term=flappy&entity=software")
        self.task = session.downloadTask(with: url, completionHandler: { (resUrl, response, err) in
            if resUrl != nil{
                let data: Data = try! Data(contentsOf: resUrl!)
                do{
                    let dic = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as AnyObject
                    self.arrData = dic.value(forKey: "results") as? [AnyObject]
                    DispatchQueue.main.async {
                        self.tblData.reloadData()
                        self.refresh.endRefreshing()
                    }
                }catch{
                    print("Fail to get data")
                }
            }
        })
        task.resume()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let data = arrData[indexPath.row] as! [String:AnyObject]
        cell.textLabel?.text = data["trackName"] as? String
        cell.imageView?.image = #imageLiteral(resourceName: "location.png")
        
        if self.cache.object(forKey: indexPath.row as AnyObject) != nil{
            cell.imageView?.image = self.cache.object(forKey: indexPath.row as AnyObject) as? UIImage
        }else{
            let strUrl = data["artworkUrl100"] as! String
            let imagUrl: URL = URL(string: strUrl)!
            
            task = session.downloadTask(with: imagUrl, completionHandler:{ (resUrl, response, err) in
                do{
                    let data: Data = try! Data(contentsOf: resUrl!)
                    DispatchQueue.main.async {
                        let img = UIImage(data: data)
                        let cell = self.tblData.cellForRow(at: indexPath)
                        cell?.imageView?.image = img
                        self.cache.setObject(img!, forKey: indexPath.row as AnyObject)
                    }
                }catch{
                    print("fail to download image")
                }
            })
            task.resume()
        }
        return cell
    }
}
