//
//  WeekViewController.swift
//  HotelApp
//
//  Created by LaNet on 2/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tblWeekList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        tblWeekList.dataSource = self
        tblWeekList.delegate = self
        
        tblWeekList.register(UINib(nibName: "WeeklyDataCell", bundle: nil), forCellReuseIdentifier: "WeeklyDataCell")
        tblWeekList.tableFooterView = UIView()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeeklyDataCell", for: indexPath) as! WeeklyDataCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .phone{
            return 140
        }else {
            return 200
        }
    }
    
}
