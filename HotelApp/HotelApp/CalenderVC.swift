//
//  CalenderVC.swift
//  HotelApp
//
//  Created by LaNet on 2/14/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class CalenderVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    //    fileprivate weak var calendar: FSCalendar!
    @IBOutlet var calendar: FSCalendar!
    
    var datesWithEvent = ["2017-02-14", "2017-02-12", "2017-02-02", "2017-02-04"]
    
    fileprivate lazy var dateFormatter1: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calendarCurrentMonthDidChange(_ calendar: FSCalendar) {
        // Do something
    }
    
    func calendar(_ calendar: FSCalendar, hasEventFor date: Date) -> Bool {
        return false
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if self.datesWithEvent.contains(self.dateFormatter2.string(from: date)){
            print("here reload events")
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventColorFor date: Date) -> UIColor? {
        let dateString = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString) {
            return UIColor.purple
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        let date = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(date){
            return UIColor.black
        }
        return UIColor.white
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let date = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(date){
            return UIColor.blue
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let date = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(date){
            return UIColor.white
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleSelectionColorFor date: Date) -> UIColor? {
        let date = self.dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(date){
            return UIColor.white
        }
        return UIColor.black
    }
    
    @IBAction func btnClick(_ sender: Any) {
        let vc = RestaurantVC(nibName: "RestaurantVC", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
