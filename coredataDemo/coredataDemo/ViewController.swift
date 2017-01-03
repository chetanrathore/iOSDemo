//
//  ViewController.swift
//  coredataDemo
//
//  Created by LaNet on 12/29/16.
//  Copyright © 2016 developer93. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tvcTask: UITableView!
    var tasks : [Task] = []
    var editIndex: IndexPath!
    var temp = 0 //added new variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvcTask.dataSource = self
        tvcTask.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        
        //     let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1//tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let count = tasks[indexPath.row].employees?.count
        if(tasks[indexPath.row].isImportant){
            cell.textLabel?.text = "😰" + tasks[indexPath.row].name! + "-\(count!)"

        }else{
            cell.textLabel?.text = tasks[indexPath.row].name! + "-\(count!)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editaction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action,indexPath) in
            let formVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FormVC") as! FormViewController
            formVC.isEdit = true
            formVC.taskId = self.tasks[indexPath.row].objectID
            self.navigationController?.pushViewController(formVC, animated: true)
            
        })
        editaction.backgroundColor = UIColor.blue
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler:{ (actin,indexPath) in
            if self.deleteTask(id: self.tasks[indexPath.row].objectID){
                self.tasks.remove(at: indexPath.row)
                self.tvcTask.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
        })
        deleteAction.backgroundColor = UIColor.red
        return [deleteAction,editaction]
    }
    
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request:NSFetchRequest<Task> = NSFetchRequest(entityName: "Task")
        let sortByName = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortByName]
    
        // let request = NSFetchRequest<Task>(entityName: "Task")
        do{
            let data = try context.fetch(request)
            
            self.tasks = []
            self.tasks = data
            
        }catch{
            print("Fetching error")
        }
        tvcTask.reloadData()
    }
    
    func deleteTask(id: NSManagedObjectID) -> Bool{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<Task>(entityName: "Task")
        do{
            if let result = try? context.fetch(request){
                for task in result{
                    if task.objectID == id{
                        context.delete(task)
                        try context.save()
                        return true
                    }
                }
            }
        }catch{
            print("Delete task fail.")
        }
        return false
    }
    
}

