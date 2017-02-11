//
//  ViewController.swift
//  LocalizationEx
//
//  Created by LaNet on 12/24/16.
//  Copyright © 2016 developer93. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var swEnglish: UISwitch!
    @IBOutlet weak var swHindi: UISwitch!
    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var swGujarati: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
   //     lblText.text = NSLocalizedString("NAME_TXT", comment: "My Name")
        
        swEnglish.tag = 0
        swHindi.tag = 1
        swGujarati.tag = 2
        
        swEnglish.addTarget(self, action: #selector(stateChange), for: UIControlEvents.valueChanged)
        swHindi.addTarget(self, action: #selector(stateChange), for: UIControlEvents.valueChanged)
        swGujarati.addTarget(self, action: #selector(stateChange), for: UIControlEvents.valueChanged)
        
        self.setData()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setData(){
        lblText.text = "GREETING".localize()
    }

    func stateChange(valChange: UISwitch){
        let tag = valChange.tag
        manageSwithch(tag: tag)
    }
    
    func manageSwithch(tag : Int){
        if(tag == 0){
            self.swEnglish.isOn = true
            self.swHindi.isOn = false
            self.swGujarati.isOn = false;
            setLanguage(langCode: ENGLISH_CODE)
        }else if(tag == 1){
            self.swEnglish.isOn = false
            self.swHindi.isOn = true
            self.swGujarati.isOn = false;
            setLanguage(langCode: HINDI_CODE)
        }else{
            self.swEnglish.isOn = false
            self.swHindi.isOn = false
            self.swGujarati.isOn = true
            setLanguage(langCode: ARABIC_CODE)
        }
        self.setData()
    }
    
    func setSwithches(){
        
    }
    
    
}

