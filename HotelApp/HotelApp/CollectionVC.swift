//
//  CollectionVC.swift
//  HotelApp
//
//  Created by LaNet on 2/18/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class MyData{
    var orderIndex: Int?
    var data: String?
    
    init() {
        orderIndex = 0
        data = "N/A"
    }
    
    init(orderIndex: Int, data: String) {
        self.orderIndex = orderIndex
        self.data = data
    }
}

class CollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var cvcCell: UICollectionView!
    
    var source: IndexPath? = nil
    var mydata = [MyData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cvcCell.register(UINib(nibName: "CollectionCell", bundle: nil), forCellWithReuseIdentifier: "CollectionCell")
        cvcCell.dataSource = self
        cvcCell.delegate = self
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        cvcCell.addGestureRecognizer(gesture)
        cvcCell.allowsMultipleSelection = false
        cvcCell.allowsSelection = true
        mydata.append(MyData(orderIndex: 0, data: "str1"))
        mydata.append(MyData(orderIndex: 1, data: "str2"))
        mydata.append(MyData(orderIndex: 2, data: "str3"))
        mydata.append(MyData(orderIndex: 3, data: "str4"))
        mydata.append(MyData(orderIndex: 4, data: "str5"))
        mydata.append(MyData(orderIndex: 5, data: "str6"))
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer){
        switch sender.state {
        case .began:
            print("here begin")
        case .changed:
            print("here changed")
        case .ended:
            print("here ended")
        default:
            print("here default")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mydata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = cvcCell.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.backgroundColor = UIColor.cyan
        let data = mydata[indexPath.row]
        cell.lblText.text = data.data
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = UIScreen.main.bounds.width/3 - 3
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if source == nil{
            self.source = indexPath
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
            cell.backgroundColor = UIColor.blue
        }else{
            let cell = collectionView.cellForItem(at: source!) as! CollectionCell
            cell.backgroundColor = UIColor.cyan
            self.cvcCell.moveItem(at: source!, to: indexPath)
            let d1 = self.mydata[(source?.row)!]
            let d2 = self.mydata[indexPath.row]
            
            self.mydata.remove(at: (source?.row)!)
            self.mydata.insert(d2, at: (source?.row)!)
            
            self.mydata.remove(at: indexPath.row)
            self.mydata.insert(d1, at: indexPath.row)
            
            self.source = nil
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell
        cell.backgroundColor = UIColor.cyan
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
    @IBAction func btnViewData(_ sender: Any) {
   
    }
}
