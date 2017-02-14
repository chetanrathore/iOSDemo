//
//  EmployeeViewController.swift
//  coredataDemo
//
//  Created by LaNet on 12/29/16.
//  Copyright © 2016 developer93. All rights reserved.
//

import UIKit
import CoreData

class EmployeeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tvcEmployee: UITableView!
    var employees : [Employee] = []
    var editIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvcEmployee.dataSource = self
        tvcEmployee.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        let btnViewEmployee = UIButton(type: .system)
        btnViewEmployee.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        btnViewEmployee.setTitle("+ new Employee", for: .normal)
        btnViewEmployee.addTarget(self, action: #selector(self.btnAddEmployee), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: btnViewEmployee)
        
        self.navigationItem.setRightBarButton(barButton, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        if(employees[indexPath.row].isTrainee){
            cell.textLabel?.text = employees[indexPath.row].name! + "(Trainee)"
        }else{
            cell.textLabel?.text = employees[indexPath.row].name! + "(Employee)"
        }
        
        cell.detailTextLabel?.text = "Technology - " + employees[indexPath.row].technology!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            if self.deleteEmployee(id: self.employees[indexPath.row].objectID){
                self.employees.remove(at: indexPath.row)
                self.tvcEmployee.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
        }
    }
    
    func getData(){
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
        tvcEmployee.reloadData()
    }
    
    func deleteEmployee(id: NSManagedObjectID) -> Bool{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Employee>(entityName: "Employee")
        do{
            if let result = try? context.fetch(request){
                for Employee in result{
                    if Employee.objectID == id{
                        context.delete(Employee)
                        try context.save()
                        return true
                    }
                }
            }
        }catch{
            print("Delete Employee fail.")
        }
        return false
    }
    
    func btnAddEmployee(sender: UIBarButtonItem){
        let manageEmpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ManageEmployeeVC") as! ManageEmployeeViewController
        self.navigationController?.pushViewController(manageEmpVC, animated: true)
    }
    
}
