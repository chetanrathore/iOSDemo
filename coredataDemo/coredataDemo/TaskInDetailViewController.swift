//
//  TaskInDetailViewController.swift
//  coredataDemo
//
//  Created by LaNet on 12/30/16.
//  Copyright © 2016 developer93. All rights reserved.
//

import UIKit
import CoreData

class TaskInDetailViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tvcTask: UITableView!
    var tasks : [Task] = []
    var isDisData = NSMutableArray()
    
    var editIndex: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvcTask.dataSource = self
        tvcTask.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 60)
        header.backgroundColor = UIColor.groupTableViewBackground
        
        let bottom = UIView()
        bottom.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 1)
        bottom.backgroundColor = UIColor.white
        
        
        var str = ""
        let task = tasks[section]
        if(task.isImportant){
            str = "😰" + task.name!
            
        }else{
            str = task.name!
        }
        
        let label = UILabel()
        label.frame = CGRect(x: 40, y: 20, width: UIScreen.main.bounds.width - 60 , height: 20)
        label.text = str
        
        if (self.tasks[section].employees?.count)! > 0{
            let button = UIButton()
            button.frame = CGRect(x: 10, y: 20, width: 20, height: 20)
            if(self.isDisData.object(at: section) as! Bool){
                button.setTitle("-", for: .normal)
            }else{
                button.setTitle("+", for: .normal)
            }
            
            button.setTitleColor(UIColor.black, for: .normal)
            button.backgroundColor = UIColor.clear
            button.addTarget(self, action: #selector(btnExpand), for: .touchUpInside)
            button.tag = section
            header.addSubview(button)
            
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: header.bounds.width - 10, height: header.bounds.height)
            btn.addTarget(self, action: #selector(btnExpand), for: .touchUpInside)
            btn.tag = section
            btn.backgroundColor = UIColor.clear
            btn.setTitleColor(UIColor.gray, for: .normal)
            if(self.isDisData.object(at: section) as! Bool){
                btn.setTitle("▼", for: .normal)
            }else{
                btn.setTitle("▶︎", for: .normal)
            }
            btn.contentHorizontalAlignment =  UIControlContentHorizontalAlignment.right
            header.addSubview(btn)
        }
        
        header.addSubview(bottom)
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let task = tasks[section]
        let count = task.employees?.count
        if(task.isImportant){
            return "😰" + task.name! + " - \(count!)"
        }else{
            return task.name! + " - \(count!)"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.isDisData.object(at: section) as! Bool){
            return (tasks[section].employees?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let employees = tasks[indexPath.section].employees
        // let allEmploee = employees?.allObjects
        let arr = Array(employees!)
        
        let emp = arr[indexPath.row] as! Employee
        
        if(emp.isTrainee){
            cell.textLabel?.text = emp.name! + "(Trainee)"
        }else{
            cell.textLabel?.text = emp.name! + "(Employee)"
        }
        cell.detailTextLabel?.text = "Technology - " + emp.technology!
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
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
            self.setDisArr()
        }catch{
            print("Fetching error")
        }
        tvcTask.reloadData()
    }
    
    func setDisArr(){
        let totalSection = self.tasks.count
        for i in 0..<totalSection{
            self.isDisData.insert(false, at: i)
        }
    }
    
    func setShowIndex(disSection: Int){
        self.isDisData.remove(at: disSection)
        self.isDisData.insert(true, at: disSection)
    }
    
    func btnExpand(sender: UIButton){
        let section = sender.tag
        if(self.isDisData.object(at: section) as! Bool){
            self.isDisData.replaceObject(at: section, with: false)
        }else{
            self.isDisData.replaceObject(at: section, with: true)
        }
        self.tvcTask.reloadSections([section], with: .fade)
        
    }
}
