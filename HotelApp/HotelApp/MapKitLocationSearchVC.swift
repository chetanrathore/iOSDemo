//
//  MapKitLocationSearchVC.swift
//  HotelApp
//
//  Created by LaNet on 2/16/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import MapKit

protocol HandleMapSearch {
    func dropPinZoomIn(paceMark: MKPlacemark)
}

class MapKitLocationSearchVC: UIViewController, CLLocationManagerDelegate, HandleMapSearch, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    //    @IBOutlet var searchbar: UISearchBar!
    
    let locationManager = CLLocationManager()
    
    var resultSearchController:UISearchController? = nil
    
    var selectedPin: MKPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        mapView.showsUserLocation = true
        //search here
        let tbl = LocationSearchTable(nibName: "LocationSearchTable", bundle: nil)
        resultSearchController = UISearchController(searchResultsController: tbl)
        resultSearchController?.searchResultsUpdater = tbl
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        tbl.mapView = mapView
        tbl.handleMapSearchDelegate = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            self.locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            let location = locations.first
            let span = MKCoordinateSpanMake(0.05, 0.05)
            let region = MKCoordinateRegion(center: (location?.coordinate)!, span: span)
            mapView.setRegion(region, animated: true)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        pinView?.pinTintColor = UIColor.orange
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(#imageLiteral(resourceName: "car"), for: .normal)
        button.addTarget(self, action:  #selector(MapKitLocationSearchVC.getDirections), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
    func dropPinZoomIn(paceMark: MKPlacemark){
        // cache the pin
        selectedPin = paceMark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = paceMark.coordinate
        annotation.title = paceMark.name
        if let city = paceMark.locality,
            let state = paceMark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(paceMark.coordinate, span)
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func btnChangeType(_ sender: UIBarButtonItem) {
        if mapView.mapType == .standard {
            self.mapView.mapType = .satellite
        }else{
            self.mapView.mapType = .standard
        }
    }
    
    func getDirections(){
        if let selectedPin = selectedPin {
            let mapItem = MKMapItem(placemark: selectedPin)
            if #available(iOS 10.0, *) {
                let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps(launchOptions: launchOptions)
            } else {
                let directionsURL = "http://maps.apple.com/?saddr=\(self.mapView.userLocation.coordinate.latitude),\(self.mapView.userLocation.coordinate.longitude)&daddr=\(selectedPin.coordinate.latitude),\(selectedPin.coordinate.longitude)"
                
                UIApplication.shared.openURL(NSURL(string: directionsURL)! as URL)
            }
        }
    }
    
}
