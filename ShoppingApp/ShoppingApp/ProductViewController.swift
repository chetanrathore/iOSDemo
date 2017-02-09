//
//  ProductViewController.swift
//  ShoppingApp
//
//  Created by LaNet on 1/12/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tvcCategory: UITableView!
    var categories = [Category]()
    var deleteIndexPath:IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCategories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setInterface() {
        tvcCategory.dataSource = self
        tvcCategory.delegate = self
        tvcCategory.register(UINib(nibName: "CategoryViewCell", bundle: nil), forCellReuseIdentifier: "CategoryViewCell")
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addCategory))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objCategory = self.categories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryViewCell", for: indexPath) as! CategoryViewCell
        cell.imgCategory.imageFromServerURL(urlString: IMG_CATEGORY + objCategory.categoryImage!, setImageColor: false)
        cell.lblCategoryName.text = objCategory.categoryName
        cell.lblDescription.text = objCategory.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.deleteIndexPath = indexPath
            self.deleteCategory()
        }
        delete.backgroundColor = UIColor.red
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            
        }
        edit.backgroundColor = UIColor.blue
        
        return [delete,edit]
    }
    
    func deleteCategory(){
    
    }
    
    
    func confirmDelete(_ indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDelete)
        let ok = UIAlertAction(title: "Delete", style: .destructive, handler: okDelete)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.popoverPresentationController?.sourceView = self.view
        self.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.width / 2, y: self.view.bounds.width / 2, width: 1, height: 1)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func cancelDelete(_ alertAction: UIAlertAction!){
        self.deleteIndexPath = nil
    }
    func okDelete(_ alertAction:UIAlertAction!){
        
//        let index = deleteIndexPath?.row
//        let categoryId = (self.categories[index!]).categoryId
//        ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: API_CATEGORIES, Str_Request_Method: "DELETE", Request_parameter: nil, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
//        }, response_Dictionary: { (result) in
// //           var message = ""
////            if let status =  result.object(forKey: "status") as? Int{
////                DispatchQueue.main.async {
////                    if status == 0 {
////                        if (result.object(forKey: "message") != nil) {
////                            message =  result.object(forKey: "message") as! String
////                            DispatchQueue.main.async {
////                                self.lblError.text = message
////                            }
////                        }
////                        self.lblError.text = message
////                    }else {
////                        self.navigationController!.popViewController(animated: true)
////                    }
////                }
////            }
//        }, response_Array: { (result) in
//        })
        self.categories.remove(at: (deleteIndexPath?.row)!)
        self.tvcCategory.deleteRows(at: [deleteIndexPath!], with: UITableViewRowAnimation.fade)
        self.tvcCategory.endUpdates()
    }
    
    func addCategory(){
        self.navigationController?.pushViewController(ManageCategoryViewController(), animated: true)
    }
    
    func getCategories() {
        ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: API_CATEGORIES, Request_parameter: nil, Request_parameter_Images: nil, isTokenEmbeded: false, status: { (status) in
        }, response_Dictionary: { (result) in
            DispatchQueue.main.async {
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
