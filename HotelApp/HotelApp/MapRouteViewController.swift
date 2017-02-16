//
//  MapRouteViewController.swift
//  HotelApp
//
//  Created by LaNet on 2/16/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import MapKit

class MapRouteViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        let source = CLLocationCoordinate2D(latitude: 40.759, longitude: -73.9845)
        let destination = CLLocationCoordinate2D(latitude: 40.748441, longitude: -73.984472)
        
        let sourcePlacemark = MKPlacemark(coordinate: source, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destination, addressDictionary: nil)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Source place"
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Destination place"
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        self.mapView.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true)
        
        let directionReq = MKDirectionsRequest()
        directionReq.source = sourceItem
        directionReq.destination = destinationItem
        directionReq.transportType = .automobile
        
        let direction = MKDirections(request: directionReq)
        
        direction.calculate { (res, err) in
            guard res != nil else {
                if let error = err {
                    print("error: \(error)")
                }
                return
            }
            let route = res?.routes[0]
            self.mapView.add((route?.polyline)!, level: MKOverlayLevel.aboveRoads)
            
            let rect = route?.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect!), animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
}
