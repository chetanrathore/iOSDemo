//
//  CategoryViewController.swift
//  imageUpload
//
//  Created by LaNet on 1/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tvcCategory: UITableView!
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tvcCategory.dataSource = self
        tvcCategory.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        getCategories()
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCategory = self.categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryViewCell
        cell.imgCategory.imageFromServerURL(urlString: baseUrl+"category/"+objCategory.categoryImage!, setImageColor: false)
        cell.lblCategoryName.text = objCategory.categoryName
        cell.lblDescription.text = objCategory.description
        return cell
    }

    func getCategories() {
        server_API.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: "category", Request_parameter: nil, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
        }, response_Dictionary: { (result) in
            DispatchQueue.main.async {
                    print(result)
            }
        }, response_Array: { (result) in
            DispatchQueue.main.async {
                self.categories.removeAll()
                self.categories = Category().jsonToArray(result: result)
                self.tvcCategory.reloadData()
            }
        })
    }

}
