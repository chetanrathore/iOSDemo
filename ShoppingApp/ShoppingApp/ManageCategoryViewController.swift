//
//  ManageCategoryViewController.swift
//  ShoppingApp
//
//  Created by LaNet on 1/13/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ManageCategoryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblError: UILabel!
    @IBOutlet var txtCategoryName: UITextField!
    @IBOutlet var txtDescription: UITextField!
    @IBOutlet var btnSave: UIButton!
    @IBOutlet var btnChooseImage: UIButton!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInterface()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblError.text = ""
    }
    
    func setInterface(){
        txtDescription = appTextField(textField: txtDescription)
        txtCategoryName = appTextField(textField: txtCategoryName)
        btnSave = appButton(appButton: btnSave, backColor: getAppColor(), textColor: getWhiteColor(), radius: true)
        btnChooseImage.setTitleColor(getAppColor(), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnChooseImage(_ sender: UIButton) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        let strCategoryName = txtCategoryName.text!
        let strDescription = txtDescription.text!
        
        if(strCategoryName.isEmpty) {
            self.lblError.text = "Category name must be required."
        }else if(strDescription.isEmpty) {
            self.lblError.text = "Description must be required."
        }else if(imgView.image == nil) {
            self.lblError.text = "Category image must be required."
        }else{
            var categoryData = [String: String]()
            categoryData["categoryName"] = txtCategoryName.text!
            categoryData["description"] = txtDescription.text!
            var imageData = [String: UIImage]()
            imageData["categoryImage1"] = imgView.image!
            ServerAPI.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: API_CATEGORIES, Str_Request_Method: "POST", Request_parameter: categoryData, Request_parameter_Images: imageData, isTokenEmbeded: false, status: { (status) in
            }, response_Dictionary: { (result) in
                var message = ""
                if let status =  result.object(forKey: "status") as? Int{
                    DispatchQueue.main.async {
                        if status == 0 {
                            if (result.object(forKey: "message") != nil) {
                                message =  result.object(forKey: "message") as! String
                                DispatchQueue.main.async {
                                    self.lblError.text = message
                                }
                            }
                            self.lblError.text = message
                        }else {
                            self.navigationController!.popViewController(animated: true)
                        }
                    }
                }
            }, response_Array: { (result) in
            })
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        self.imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
}
