//
//  RestaurantVC.swift
//  HotelApp
//
//  Created by LaNet on 2/15/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class RestaurantVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var segment: UISegmentedControl!
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    
    @IBOutlet var tblRestaurant: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationItem = UIBarButtonItem(customView: segmentControl)
        self.navigationItem.rightBarButtonItem = navigationItem
        tblRestaurant.dataSource = self
        tblRestaurant.delegate = self
        tblRestaurant.register(UINib(nibName: "RestuarantCell", bundle: nil), forCellReuseIdentifier: "RestuarantCell")
        tblRestaurant.estimatedRowHeight = 160
        tblRestaurant.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestuarantCell", for: indexPath) as! RestuarantCell
        if indexPath.row == 1 {
        cell.lblDetails.text = "fgf fg rgdfg fgfg fgfg fgfg fgfg fgg fgfdg fgg fgfg gdfgfg dfgdfg fgdfg fgfdg fgdfgkdgjdlfgk fklgjdlfkgjlkdfgjldfgjfgf fg rgdfg fgfg fgfg fgfg fgfg fgg fgfdg fgg fgfg gdfgfg dfgdfg fgdfg fgfdg fgdfgkdgjdlfgk fklgjdlfkgjlkdfgjldfgjfgf fg rgdfg fgfg fgfg fgfg fgfg fgg fgfdg fgg fgfg gdfgfg dfgdfg fgdfg fgfdg fgdfgkdgjdlfgk fklgjdlfkgjlkdfgjldfgjfgf fg rgdfg fgfg fgfg fgfg fgfg fgg fgfdg fgg fgfg gdfgfg dfgdfg fgdfg fgfdg fgdfgkdgjdlfgk fklgjdlfkgjlkdfgjldfgj"
        }
        let date = Date()
        cell.lblDateTime.text = String(describing: date)
        return cell
        
    }
}
