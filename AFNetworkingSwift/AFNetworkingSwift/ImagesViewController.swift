//
//  ImagesViewController.swift
//  AFNetworkingSwift
//
//  Created by LaNet on 3/18/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tblImages: UITableView!
    var images = [Photos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblImages.dataSource = self
        tblImages.delegate = self
        tblImages.register(UINib(nibName: "ImageCell", bundle: nil), forCellReuseIdentifier: "ImageCell")
        self.navigationController?.navigationBar.isHidden = true
        tblImages.estimatedRowHeight = 200
        tblImages.rowHeight = UITableViewAutomaticDimension
        getImageData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        let photos = images[indexPath.row]
        cell.lblTitle.text = photos.title
//        let url = NSURL(string: photos.url)
//        let request = URLRequest(url: url as! URL)
//        cell.img.setImageWith(request, placeholderImage: UIImage(named: "load.gif"), success: { (urlRequest, response,image) in
//            cell.img.image = image
//        }) { (urlRequest, response, error) in
//            print(error)
//        }
        cell.img.setImage(urlStr: photos.thumbnailUrl)
        
        return cell
    }

    func getImageData() {
        let manger = AFHTTPSessionManager()
        manger.get("https://jsonplaceholder.typicode.com/photos", parameters: nil, progress: { (progress) in
            
        }, success: { (task, result) in
            self.images = Photos().toPhotos(jsonData: result)
            
            self.tblImages.reloadData()
        }) { (task, error) in
            
        }
    }
    
}
