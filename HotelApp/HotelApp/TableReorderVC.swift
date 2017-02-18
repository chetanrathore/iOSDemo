//
//  TableReorderVC.swift
//  HotelApp
//
//  Created by LaNet on 2/18/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class TableReorderVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tblData: UITableView!
    var data = ["One","Two","Three","Four","Five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblData.dataSource = self
        tblData.delegate = self
        self.tblData.isEditing = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }

}
