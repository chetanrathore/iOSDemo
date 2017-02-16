//
//  LazyloadingVC.swift
//  ObjectMappperDemo
//
//  Created by LaNet on 2/15/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import ObjectMapper

class LazyloadingVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var category = [Category]()
    var pageNo: Int = 0
    var totalPages: Int = 0
    @IBOutlet var tblCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblCategory.dataSource = self
        tblCategory.delegate = self
        getCategory()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getCategory() {
        APIService.sharedInstance.sendRequest(method: "GET", postedData: [:], apiMethod: apiCategory+String(pageNo), completion: { (resultData, isError, isConnectionError) in
            print(resultData)
            let data = resultData as! NSDictionary
            let category = data.value(forKey: "category")
            self.pageNo = data.value(forKey: "pageNo") as! Int
            self.totalPages = data.value(forKey: "totalPage") as! Int
            var categoryData = [Category]()
            categoryData = Mapper<Category>().mapArray(JSONArray: category as! [[String: Any]])!
            self.category += categoryData
            self.tblCategory.reloadData()
        })
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let category = self.category[indexPath.row]
        cell.textLabel?.text = category.categoryName
        cell.detailTextLabel?.text = category.cDescription
        if indexPath.row == (self.category.count - 1) {
            self.pageNo += 1
            if pageNo < totalPages {
                self.getCategory()
            }
        }
        return cell
    }

}
