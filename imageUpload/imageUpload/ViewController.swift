//
//  ViewController.swift
//  imageUpload
//
//  Created by LaNet on 1/10/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @IBOutlet var imgView: UIImageView!
    var imagePicker: UIImagePickerController!
    @IBOutlet var btnUpload: UIButton!
    @IBOutlet var lblError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        btnUpload.isHidden = true
        lblError.text = ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnChooseImg(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        btnUpload.isHidden = false
        self.imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnUpload(_ sender: UIButton) {
        var categoryData = [String: String]()
        categoryData["categoryName"] = "Test from app"
        categoryData["description"] = "test"
        var imageData = [String: UIImage]();
        imageData["categoryImage1"] = imgView.image!
        imageData["categoryImage3"] = UIImage(named: "123.jpg")
        
        server_API.sharedObject.requestFor_NSMutableDictionary(Str_Request_Url: "category", Request_parameter: categoryData, Request_parameter_Images: imageData, isTokenEmbeded: false, status: { (status) in
        }, response_Dictionary: { (result) in
            if let message =  result.object(forKey: "message"){
                DispatchQueue.main.async {
                    self.lblError.text = message as? String
                }
            }
        })
        btnUpload.isHidden = true
    }
    
}

