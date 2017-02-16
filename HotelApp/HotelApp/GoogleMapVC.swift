//
//  GoogleMapVC.swift
//  HotelApp
//
//  Created by LaNet on 2/16/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    
    
    let infoMarker = GMSMarker()
    
    var locationManager = CLLocationManager()
    var vwGMap = GMSMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 22.300000, longitude: 70.783300, zoom: 10.0)
        vwGMap = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        vwGMap.camera = camera
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
      //  locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.view = vwGMap
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            vwGMap.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last
        vwGMap.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 15.0)
        vwGMap.settings.myLocationButton = true
        self.view = self.vwGMap
        infoMarker.position = CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude)
        infoMarker.map = self.vwGMap
        
    }
    /*
     override func loadView() {
     // Create a GMSCameraPosition that tells the map to display the
     // coordinate -33.86,151.20 at zoom level 6.
     let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
     let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
     view = mapView
     
     // Creates a marker in the center of the map.
     //        let marker = GMSMarker()
     //        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
     //        marker.title = "Sydney"
     //        marker.snippet = "Australia"
     //        marker.map = mapView
     
     // mapView.mapType = kGMSTypeHybrid//kGMSTypeSatellite//kGMSTypeTerrain
     mapView.isIndoorEnabled = false
     mapView.accessibilityElementsHidden = false
     
     // The myLocation attribute of the mapView may be null
     if let mylocation = mapView.myLocation {
     print("User's location: \(mylocation)")
     } else {
     print("User's location is unknown")
     }
     
     let mapInsets = UIEdgeInsets(top: 100.0, left: 0.0, bottom: 0.0, right: 300.0)
     mapView.padding = mapInsets
     
     mapView.delegate = self
     }
     */
    
    /*
     override func loadView() {
     let panoView = GMSPanoramaView(frame: .zero)
     self.view = panoView
     
     panoView.moveNearCoordinate(CLLocationCoordinate2D(latitude: -33.732, longitude: 150.312))
     }*/
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        infoMarker.opacity = 0;
        infoMarker.infoWindowAnchor.y = 1
        infoMarker.map = mapView
        mapView.selectedMarker = infoMarker
    }
    
    
    
}
