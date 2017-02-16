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
    @IBOutlet var mapView: MKMapView!
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
        self.setMapView()
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
    
    func setMapView() {
        
        self.mapView.showsUserLocation = true
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.requestWhenInUseAuthorization()
            locationManager.requestAlwaysAuthorization()
            locationManager.startMonitoringSignificantLocationChanges()
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            mapView.mapType = .standard
            
        } else {
            print("Location services are not enabled");
        }
        mapView.delegate = self
        
        //Set all anotations here accept user location
        //Span for zoom map or clear map path
        var span = MKCoordinateSpan()
        span.latitudeDelta = 0.8
        span.longitudeDelta = 0.8
        
        let coordinate1 = CLLocationCoordinate2DMake(28.889281, 75.836042)
        let mapRegion1 = MKCoordinateRegion(center: coordinate1, span: span)
        mapView.setRegion(mapRegion1, animated: true)
        //Create a pin annotation
        let pointAnnotation1 = CustomPointAnnotation()
        pointAnnotation1.coordinate = coordinate1
        pointAnnotation1.title = "MARK1"
        pointAnnotation1.subtitle = "here"
        let pinAnnotationView1 = MKPinAnnotationView(annotation: pointAnnotation1, reuseIdentifier: "care")
        mapView.setRegion(mapRegion1, animated: true)
        mapView.addAnnotation(pinAnnotationView1.annotation!)
        
        let coordinate = CLLocationCoordinate2DMake(30.889281, 75.836042)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(mapRegion, animated: true)
        let pointAnnotation2 = CustomPointAnnotation()
        pointAnnotation2.coordinate = coordinate
        pointAnnotation2.title = "Location2"
        pointAnnotation2.subtitle = "here"
        let pinAnnotationView2 = MKPinAnnotationView(annotation: pointAnnotation2, reuseIdentifier: "care")
        mapView.addAnnotation(pinAnnotationView2.annotation!)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        if annotation is CustomPointAnnotation {
            let identifier = "pin"
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if pinView == nil {
                //Create a plain MKAnnotationView if using a custom image...
                pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                pinView!.canShowCallout = true
                pinView?.image = UIImage(named: "Marker.png")
                let guester = UITapGestureRecognizer(target: self, action: #selector(self.tapPinInMap))
                //Here set Id of care service
                pinView?.tag = 2
                pinView?.gestureRecognizers = [guester]
            }
            else {
                //Update the annotation reference if re-using a view...
                pinView?.annotation = annotation
            }
            return pinView
        }
        return nil
    }
    
    //Which pin is selected
    func tapPinInMap(sender: UITapGestureRecognizer) {
        let selectedPin = (sender.view)!.tag
        print(selectedPin)
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("ERROR:\(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        let coord = locationObj.coordinate
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coord
        mapView.addAnnotation(pointAnnotation)
        
        print("longitude:\(coord.longitude)")
        print("latitude:\(coord.latitude)")
        
        // locationManager.stopUpdatingLocation()
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
        if self.mapView.annotations.count != 0{
            annotation = self.mapView.annotations[0]
            self.mapView.removeAnnotation(annotation)
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
            self.mapView.centerCoordinate = self.pointAnnotation.coordinate
            self.mapView.addAnnotation(self.pinAnnotationView.annotation!)
            self.locationManager.startUpdatingLocation()
        }
    }
    
    
    @IBAction func btnMapType(_ sender: Any) {
        if mapView.mapType == .standard {
            self.mapView.mapType = .satellite
        }else{
            self.mapView.mapType = .standard
        }
    }
    
}

class CustomPointAnnotation: MKPointAnnotation {
    var pinCustomImageName:String!
}

