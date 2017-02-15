//
//  ProgressVC.swift
//  HotelApp
//
//  Created by LaNet on 2/11/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ProgressVC: UIViewController {

    @IBOutlet var progressView: UIProgressView!

    @IBOutlet var lblProgress: UILabel!
    @IBOutlet var imgAnimation: UIImageView!
    @IBOutlet var img: UIImageView!
    var timer: Timer!
    
    var val: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.img.isHidden = true
        self.imgAnimation.isHidden = true
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setProgress), userInfo: nil, repeats: true)
        imgAnimation.layer.cornerRadius = imgAnimation.frame.width/2
        imgAnimation.clipsToBounds = true
        img.layer.cornerRadius = img.frame.width/2
        img.clipsToBounds = true
//        imgAnimation.layer.borderWidth = 5
//        imgAnimation.layer.borderColor = UIColor.black.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        progressView.progress = 0
//        //Perform detaly here
//        let delay = 4.0
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+delay) {
//            for i in 0...10{
//                self.lblProgress.text = String(i)
//                self.progressView.progress = Float(i) / Float(10)
//            }
//        }
        
        UIView.animate(withDuration: 0.9, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.imgAnimation.alpha = 0
            self.img.alpha = 1
           // self.imgAnimation.frame = CGRect(x: self.imgAnimation.frame.origin.x, y: self.imgAnimation.frame.origin.x, width: 50, height: 50)
        }, completion: nil)
        
    }
    
    func setProgress() {
        self.progressView.progress = self.val/10
        self.lblProgress.text = String(self.val)
        val += 1;
        if val == 10{
            timer.invalidate()
        }
    }
    
}
