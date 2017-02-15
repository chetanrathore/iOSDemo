//
//  MapVC.swift
//  HotelApp
//
//  Created by LaNet on 2/10/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet var btnNavLeft: UIButton!
    
    @IBOutlet var btnAction: UIButton!
    
    @IBOutlet var txtSearchbar: UISearchBar!
    @IBOutlet var map: MKMapView!
    @IBOutlet var btnUserLocation: UIButton!
    
    var searchController:UISearchController!
    var annotation:MKAnnotation!
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    var error:NSError!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtSearchbar.delegate = self
        //        showSearchBar()
        mapkit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        setInterface()
    }
    
    func setInterface() {
        self.navigationController?.navigationBar.isHidden = true
        self.txtSearchbar.barTintColor = UIColor.white
        self.txtSearchbar.tintColor = UIColor.gray
        btnUserLocation.layer.cornerRadius = self.btnUserLocation.frame.width/2
        btnUserLocation.clipsToBounds = true
    }
    
    func mapkit() {
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
            
        } else {
            print("Location services are not enabled");
        }
        
        map.delegate = self
        map.mapType = .standard
        map.showsUserLocation = true
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        locationManager.stopUpdatingLocation()
    }
    //
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        return MKAnnotationView()
    //    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        if self.map.userLocation.coordinate.latitude != location.coordinate.latitude ||
            self.map.userLocation.coordinate.longitude != location.coordinate.longitude {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08))
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "My location"
            
            self.map.setRegion(region, animated: true)
            self.map.addAnnotation(annotation)
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
        
    }
    
    @IBAction func handleBtnUserLocation(_ sender: UIButton) {
        self.locationManager.startUpdatingLocation()
    }
    
    //    func showSearchBar() {
    //        searchController = UISearchController(searchResultsController: nil)
    //        searchController.hidesNavigationBarDuringPresentation = false
    //        self.searchController.searchBar.delegate = self
    //        present(searchController, animated: true, completion: nil)
    //    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        //1
        searchBar.resignFirstResponder()
        // dismiss(animated: true, completion: nil)
        if self.map.annotations.count != 0{
            annotation = self.map.annotations[0]
            self.map.removeAnnotation(annotation)
        }
        //2
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                return
            }
            //3
            self.locationManager.startUpdatingLocation()
            self.pointAnnotation = MKPointAnnotation()
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude: localSearchResponse!.boundingRegion.center.longitude)
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.map.centerCoordinate = self.pointAnnotation.coordinate
            self.map.addAnnotation(self.pinAnnotationView.annotation!)
            self.locationManager.startUpdatingLocation()
        }
    }
    
}
