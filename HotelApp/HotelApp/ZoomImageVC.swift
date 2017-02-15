//
//  ZoomImageVC.swift
//  HotelApp
//
//  Created by LaNet on 2/14/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit

class ZoomImageVC: UIViewController, UIScrollViewDelegate {

   // @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var doubleTap: UITapGestureRecognizer!
    
    var scrollView: UIScrollView!
    
    let image = UIImage(named: "bike.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.main.bounds.width
        let shotWidth: CGFloat = 320
        
        let shotHeight: CGFloat = 480
        let aspect: CGFloat = width / shotWidth
        
        let frame = CGRect(x: 0, y: 0, width: shotWidth * aspect, height: shotHeight * aspect)
        self.scrollView = UIScrollView(frame: frame)
        
        self.scrollView!.bounces = false
        self.scrollView!.showsHorizontalScrollIndicator = false
        self.scrollView!.showsVerticalScrollIndicator = false
        self.scrollView!.isUserInteractionEnabled = true
        self.scrollView!.delegate = self
        self.scrollView!.bouncesZoom = false
        self.scrollView!.scrollsToTop = false
        self.scrollView!.maximumZoomScale = 2.0
        self.scrollView!.minimumZoomScale = 1.0
        
        self.doubleTap = UITapGestureRecognizer(target: self, action: #selector(zoom))
        self.doubleTap!.numberOfTapsRequired = 2
        self.doubleTap!.numberOfTouchesRequired = 1
        self.scrollView!.addGestureRecognizer(self.doubleTap!)
        
        // This was run when the animation is complete
        self.imageView!.removeFromSuperview()
        self.scrollView!.addSubview(self.imageView!)
        self.view.addSubview(self.scrollView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView!
    }
    
    func loadImage() {
        // This is run in the callback when the full image has been loaded (image = UIImage)
        self.imageView!.frame = CGRect(x: 0, y: 0, width: (image?.size.width)!, height: (image?.size.height)!)
         self.imageView!.image = image
        self.scrollView!.contentSize = (image?.size)!
        
        let imgwidth = CGFloat(self.view.bounds.size.width / (image?.size.width)!)
        let imgheight = CGFloat(self.view.bounds.size.height / (image?.size.height)!)
        let minZoom: CGFloat = min(imgwidth, imgheight)
        
//        NSLog("image size: %@ / %f", NSStringFromCGSize(image.size), minZoom)
        
        if (minZoom <= 1) {
            self.scrollView!.minimumZoomScale = minZoom
            self.scrollView!.setZoomScale(minZoom, animated: false)
            self.scrollView!.zoomScale = minZoom
        }
    }
    
    func zoom(tapGesture: UITapGestureRecognizer) {
        if (self.scrollView!.zoomScale == self.scrollView!.minimumZoomScale) {
            let center = tapGesture.location(in: self.scrollView!)
            let size = self.imageView!.image!.size
            let zoomRect = CGRect(x: center.x, y: center.y, width: (size.width / 2), height: (size.height / 2));            self.scrollView!.zoom(to: zoomRect, animated: true)
        } else {
            self.scrollView!.setZoomScale(self.scrollView!.minimumZoomScale, animated: true)
        }
    }
    
}
