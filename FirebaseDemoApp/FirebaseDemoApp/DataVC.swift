//
//  DataVC.swift
//  FirebaseDemoApp
//
//  Created by LaNet on 2/13/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DataVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblItem: UITableView!
    
    var user: FIRUser!
    var items = [Item]()
    var ref: FIRDatabaseReference!
    private var databaseHandle: FIRDatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblItem.delegate = self
        self.tblItem.dataSource = self
        
        self.user = FIRAuth.auth()?.currentUser
        self.ref = FIRDatabase.database().reference()
        startObservingDatabase()
        
        let signOutBtn = UIButton(type: .system)
        signOutBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        signOutBtn.setTitle("Sign Out", for: .normal)
        signOutBtn.addTarget(self, action: #selector(self.signOut), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: signOutBtn)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "datacell")
        let item = self.items[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let item = items[indexPath.row]
            item.ref?.removeValue()
        }
    }
    
    func startObservingDatabase () {
        databaseHandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { (snapshot) in
            var newItems = [Item]()
            
            for itemSnapShot in snapshot.children {
                let item = Item(snapShot: itemSnapShot as! FIRDataSnapshot)
                newItems.append(item)
            }
            self.items = newItems
            self.tblItem.reloadData()
            
        })
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        let prompt = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let userInput = prompt.textFields![0].text
            if (userInput!.isEmpty) {
                return
            }
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(userInput)
        }
        prompt.addTextField(configurationHandler: nil)
        prompt.addAction(okAction)
        present(prompt, animated: true, completion: nil);
        
    }
    
    func signOut(sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            self.navigationController!.popToRootViewController(animated: true)
            
        } catch let error {
            assertionFailure("Error signing out: \(error)")
        }
    }
    
    deinit {
        ref.child("users/\(self.user.uid)/items").removeObserver(withHandle: databaseHandle)
    }
}
