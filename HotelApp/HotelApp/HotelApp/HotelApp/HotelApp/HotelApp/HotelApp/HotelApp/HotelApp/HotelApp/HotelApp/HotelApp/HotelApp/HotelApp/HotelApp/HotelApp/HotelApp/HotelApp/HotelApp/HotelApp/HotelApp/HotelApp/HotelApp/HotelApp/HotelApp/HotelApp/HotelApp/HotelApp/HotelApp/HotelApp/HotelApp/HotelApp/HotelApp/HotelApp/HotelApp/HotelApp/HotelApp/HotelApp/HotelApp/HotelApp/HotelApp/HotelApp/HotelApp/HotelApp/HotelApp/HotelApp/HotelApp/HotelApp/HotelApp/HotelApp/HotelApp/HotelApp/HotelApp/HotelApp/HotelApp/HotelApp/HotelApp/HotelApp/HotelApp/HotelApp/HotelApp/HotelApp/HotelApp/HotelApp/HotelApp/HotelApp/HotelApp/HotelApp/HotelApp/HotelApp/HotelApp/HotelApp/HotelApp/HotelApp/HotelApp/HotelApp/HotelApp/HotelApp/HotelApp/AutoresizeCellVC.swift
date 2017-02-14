//
//  AutoresizeCellVC.swift
//  HotelApp
//
//  Created by LaNet on 2/14/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class AutoresizeCellVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tblData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblData.dataSource = self
        tblData.delegate = self
        tblData.estimatedRowHeight = 60
        tblData.rowHeight = UITableViewAutomaticDimension
        tblData.register(UINib(nibName: "AutoSizeCell", bundle: nil), forCellReuseIdentifier: "AutoSizeCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AutoSizeCell", for: indexPath) as! AutoSizeCell
        cell.lblName.text = "dfgffhhggh ddfgg"
        cell.lblAddress.text = "Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg"
        if indexPath.row == 4 {
            cell.lblAddress.text = "Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg"
        }
        if indexPath.row == 2 {
            cell.lblAddress.text = "Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg"
        }
        if indexPath.row == 5 {
            cell.lblName.text = "Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg"
            cell.lblAddress.text = "Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdgSurat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdgSurat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdgSurat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg Surat efmlk klmrgfl rlgklk dlgdlfg fgg gfdg"
        }
        return cell
    }
    
    
}
