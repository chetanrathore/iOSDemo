//
//  ManageEmployeeViewController.swift
//  coredataDemo
//
//  Created by LaNet on 12/29/16.
//  Copyright © 2016 developer93. All rights reserved.
//

import UIKit
import CoreData

class ManageEmployeeViewController: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtTechnology: UITextField!
    @IBOutlet var isTrainee: UISwitch!
    @IBOutlet var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if(txtName.text!.isEmpty){
            showAlert(msg:"Name must be required.")
        }else if(txtTechnology.text!.isEmpty){
            showAlert(msg:"Technology must be required.")
        }
        else{
           addEmployee()
        }
    }
    
    func showAlert(msg: String){
        let alert = UIAlertController(title: "Oops!", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func addEmployee(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let employee = Employee(context: context)
        employee.name = txtName.text!
        employee.isTrainee = isTrainee.isOn
        employee.technology = txtTechnology.text!
        do{
            try context.save()
            navigationController!.popViewController(animated: true)
        }catch{
            showAlert(msg: "Fail to add Employee, \n try again.")
            print("Save Error...")
        }
    }

}
