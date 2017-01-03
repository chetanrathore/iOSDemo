//
//  FormViewController.swift
//  coredataDemo
//
//  Created by LaNet on 12/29/16.
//  Copyright © 2016 developer93. All rights reserved.
//

import UIKit
import CoreData

class FormViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var txtTask: UITextField!
    @IBOutlet var isImportant: UISwitch!
    @IBOutlet var btnSave: UIButton!
    
    @IBOutlet var bottomView: UIView!
    @IBOutlet var pickerView: UIPickerView!
    
    @IBOutlet var btnAssignTask: UIButton!
    @IBOutlet var lblAssignTo: UILabel!
    
    
    @IBOutlet var bottonContrain: NSLayoutConstraint!
    var isEdit:Bool = false
    var taskId:NSManagedObjectID!
    
    var employees: [Employee] = []
    var selectedEmp: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTaskById()
        
        let btnViewEmployee = UIButton(type: .system)
        btnViewEmployee.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
        btnViewEmployee.setTitle("Employees", for: .normal)
        btnViewEmployee.addTarget(self, action: #selector(self.btnViewEmployee), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnViewEmployee)
        
        self.navigationItem.setRightBarButton(barButton, animated: true)
        
        self.lblAssignTo.text = ""
        bottonContrain.constant = -500
        pickerView.delegate = self
        pickerView.dataSource = self
        //   self.bottomView.isHidden = true
        getEmployeeData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        if(txtTask.text!.isEmpty){
            showAlert(msg:"Task name must be required.")
        }else{
            if isEdit{
                editTask()
            }else{
                addTask()
            }
        }
    }
    
    func showAlert(msg: String){
        let alert = UIAlertController(title: "Oops!", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getTaskById(){
        if(isEdit){
            btnAssignTask.isHidden = true
            btnSave.setTitle("Save", for: .normal)
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request = NSFetchRequest<Task>(entityName: "Task")
            do{
                if let data = try? context.fetch(request){
                    for obj in data{
                        if obj.objectID == self.taskId{
                            txtTask.text = obj.name!
                            isImportant.isOn = obj.isImportant
                            return
                        }
                    }
                }else{
                    navigationController!.popViewController(animated: true)
                }
            }
        }else{
            btnSave.setTitle("Add", for: .normal)
        }
    }
    
    func editTask(){
        do{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request = NSFetchRequest<Task>(entityName: "Task")
            if let data = try? context.fetch(request){
                for obj in data{
                    if obj.objectID == self.taskId{
                        obj.name = txtTask.text!
                        obj.isImportant = isImportant.isOn
                        try context.save()
                        navigationController!.popViewController(animated: true)
                    }
                }
            }
        }catch{
            showAlert(msg: "Fail to update task, \n try again.")
            print("Edit Error.")
        }
    }
    
    //Add task
    func addTask(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context)
        task.name = txtTask.text!
        task.isImportant = isImportant.isOn
        
//        let employee = Employee(context: context)
//        employee.name = "Abc"
//        employee.isTrainee = false
//        employee.technology = "iOS"
     //   task.addToEmployee(employee)
        
//        for obj in selectedEmp{
//            
//         //   task.addToEmployee(obj)
//        }
        task.employees = NSSet(array: selectedEmp)
        do{
            try context.save()
            navigationController!.popViewController(animated: true)
        }catch{
            showAlert(msg: "Fail to add task, \n try again.")
            print("Save Error...")
        }
    }
    
    func btnViewEmployee(sender: UIBarButtonItem){
        let empVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeVC") as! EmployeeViewController
        self.navigationController?.pushViewController(empVC, animated: true)
    }
    
    //Assign task
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return employees.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let trainee = (employees[row].isTrainee) ? "T" : "E"
        let str = employees[row].name! + "(" + trainee + ")" + "-" + employees[row].technology!
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var str = ""
        let emp = employees[row]
        if !selectedEmp.contains(emp){
            selectedEmp.append(emp)
        }else{
            selectedEmp = selectedEmp.filter { Employee in
                return (Employee.objectID != emp.objectID)
            }
        }
        for obj in selectedEmp{
            let trainee = (obj.isTrainee) ? "T" : "E"
            str += obj.name! + "(" + trainee + ")" + "-" + obj.technology! + "\n"
        }
        lblAssignTo.text = str
    }
    
    @IBAction func btnAssignTask(_ sender: UIButton) {
        UIView.animate(withDuration: 0.9, animations: {
            self.bottonContrain.constant = 0
        })
    }
    @IBAction func btnDone(_ sender: UIButton) {
        UIView.animate(withDuration: 0.9, animations: {
            self.bottonContrain.constant = -500
        })
    }
    
    func getEmployeeData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request:NSFetchRequest<Employee> = NSFetchRequest(entityName: "Employee")
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortByName]
        
        // let request = NSFetchRequest<Employee>(entityName: "Employee")
        do{
            let data = try context.fetch(request)
            
            self.employees = []
            self.employees = data
            
        }catch{
            print("Fetching error")
        }
    }
    
    
    
}
