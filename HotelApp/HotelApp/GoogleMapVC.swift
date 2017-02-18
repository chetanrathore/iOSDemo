//
//  GoogleMapVC.swift
//  HotelApp
//
//  Created by LaNet on 2/16/17.
//  Copyright © 2017 developer93. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    @IBOutlet var searchbar: UISearchBar!
    
    @IBOutlet var segmentMapType: UISegmentedControl!
    @IBOutlet var mapVIew: GMSMapView!
    let infoMarker = GMSMarker()
    
    var locationManager = CLLocationManager()
    var vwGMap = GMSMapView()
    
    var mapItem = [MapPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        //  locationManager.distanceFilter = 500
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapVIew.settings.myLocationButton = true
        mapVIew.isMyLocationEnabled = true
        searchbar.delegate = self
        mapVIew.delegate = self
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            print("Location services are not enabled")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            mapVIew.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if mapVIew.myLocation?.coordinate.latitude != locations.last?.coordinate.latitude ||
            mapVIew.myLocation?.coordinate.longitude != locations.last?.coordinate.longitude {
            let newLocation = locations.last
            mapVIew.camera = GMSCameraPosition.camera(withTarget: newLocation!.coordinate, zoom: 15.0)
            infoMarker.position = CLLocationCoordinate2DMake(newLocation!.coordinate.latitude, newLocation!.coordinate.longitude)
            infoMarker.map = self.mapVIew
        }
        mapVIew.bringSubview(toFront: segmentMapType)
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            if let address = response?.firstResult() {
                
                // 3
                let lines = address.lines//address.lines as? [String]
                let txt = lines?.joined(separator: "\n")
                print(txt ?? "Not found")
                // 4
                UIView.animate(withDuration: 0.25) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        locationManager.startUpdatingLocation()
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty)! {
            let str = searchBar.text?.trimmingCharacters(in: .whitespaces)
            sendRequest(str: str!)
        }
    }
    
    func sendRequest(str: String) {
        
        if locationManager.location != nil{
            let location = (locationManager.location?.coordinate)!
            let str = "https://maps.googleapis.com/maps/api/place/search/json?location=\(location.latitude),\(location.longitude)&radius=500&types=\(str)&sensor=true&key=AIzaSyCwnZjVMIvsZS0UJf98LqCdNArrr3uBpng"
            
            var request = URLRequest(url: URL(string: str)!)
            request.httpMethod = "GET"
            //DispatchQueue.main.async {
            URLSession.shared.dataTask(with: request) {data, response, err in
                if err != nil {
                    print("Error:- \(err)")
                }else{
                    DispatchQueue.main.async(execute: {
                        let json = try! JSONSerialization.jsonObject(with: data!, options:  JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                        print(json)
                        self.mapItem.removeAll()
                        let result = json.value(forKey: "results") as! NSArray
                        for data in result{
                            let data = data as AnyObject
                            let mapPoint = MapPoint()
                            if let title = data["name"] as? String{
                                mapPoint.name = title
                            }
                            if data["geometry"] != nil{
                                let geometry = data["geometry"] as AnyObject
                                let location = geometry["location"] as! NSDictionary
                                mapPoint.lat = location.value(forKey: "lat") as? CLLocationDegrees
                                mapPoint.lng = location.value(forKey: "lng") as? CLLocationDegrees
                            }
                            if let icon = data["icon"] as? String{
                                mapPoint.imgIcon = icon
                            }
                            if let rating = data["rating"] as? Float{
                                mapPoint.rating = rating
                            }
                            self.mapItem.append(mapPoint)
                        }
                        self.setPint()
                    })
                }
                }.resume()
            //    }
        }
    }
    
    func setPint() {
        self.mapVIew.clear()
        let marker = GMSMarker(position: (mapVIew.myLocation?.coordinate)!)
        marker.title = "My Location"
        marker.map = self.mapVIew!
        
        for map in mapItem{
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: map.lat!, longitude: map.lng!))
            marker.title = map.name
            marker.map = self.mapVIew!
            marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
            marker.appearAnimation = kGMSMarkerAnimationPop
            if let url = URL(string: map.imgIcon!) {
                getDataFromUrl(url: url) { (data, response, error)  in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? url.lastPathComponent)
                    print("Download Finished")
                    DispatchQueue.main.async() { () -> Void in
                        var img = UIImage(data: data)
                        img = img?.resizedImage(newSize: CGSize(width: 20, height: 20))
                        marker.icon = img
                    }
                }
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    @IBAction func changeMap(_ sender: UISegmentedControl) {
        switch segmentMapType.selectedSegmentIndex {
        case 0:
            self.mapVIew.mapType = kGMSTypeNormal
        case 1:
            self.mapVIew.mapType = kGMSTypeSatellite
        default:
            break
        }
    }
    
    /*
     func queryGooglePlaces(_ googleType: String) {
     
     let allAnnotations = self.mapView.annotations
     self.mapView.removeAnnotations(allAnnotations)
     
     let url = "https://maps.googleapis.com/maps/api/place/search/json?location=\(mapView.userLocation.coordinate.latitude),\(mapView.userLocation.coordinate.longitude)&radius=\("\(currenDist)")&types=cafe&sensor=true&key=\(googleMapAPIKey)"
     
     let googleRequestURL = URL(string: url)!
     
     kBgQueue.async(execute: {() -> Void in
     let data = try? Data(contentsOf: googleRequestURL)
     self.performSelector(onMainThread: #selector(self.fetchedData), with: data, waitUntilDone: true)
     })
     }
     
     func fetchedData(_ responseData: Data) {
     
     var error: NSError?
     let json = try! JSONSerialization.jsonObject(with: responseData, options:  JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
     print(json)
     
     let result = json.value(forKey: "results") as! NSArray
     
     for singleresult in result{
     let place = ((singleresult as AnyObject).value(forKey: "geometry") as AnyObject).value(forKey: "location")
     
     //print(place)
     
     let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: (place! as AnyObject).value(forKey: "lat") as! CLLocationDegrees, longitude: (place! as AnyObject).value(forKey: "lng") as! CLLocationDegrees), addressDictionary: nil)
     
     //let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
     let sourceAnnotation = MKPointAnnotation()
     
     if let location = sourcePlacemark.location {
     sourceAnnotation.coordinate = location.coordinate
     }
     
     self.mapView.addAnnotation(sourceAnnotation)
     }
     
     
     //print(json.valueForKey("results")?.objectAtIndex(0).valueForKey("geometry")?.valueForKey("location"))
     // let places = json.valueForKey("results")?.objectAtIndex(0).valueForKey("geometry")?.valueForKey("location")
     //Write out the data to the console.
     //print("Google Data: \(places)")
     }
     */
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

class MapPoint {
    var location: CLLocationCoordinate2D?
    var lat: CLLocationDegrees?
    var lng: CLLocationDegrees?
    var imgIcon: String?
    var name: String?
    var id: String?
    var rating: Float?
    var placeId: String?
    var photo: String?
    var vicinity: String?
}

extension UIImageView {
    
    public func imageFromServerURL(urlString: String,setImageColor: Bool = false) {
        let downloadActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        downloadActivityIndicator.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        //               downloadActivityIndicator.color = UIColor.gray
        downloadActivityIndicator.startAnimating()
        self.addSubview(downloadActivityIndicator)
        //           DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            print(data!)
            if error != nil {
                downloadActivityIndicator.removeFromSuperview()
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                downloadActivityIndicator.removeFromSuperview()
                if let image = UIImage(data: data!) {
                    if(setImageColor) {
                        self.image = image.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
                        //                        self.tintColor = getAppColor()
                    }else {
                        self.image = image
                    }
                }else {
                    self.image = UIImage(named: "Map_Marker.png")
                }
            })
        }).resume()
        //          })
    }
    
    func tintImageColor(color: UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}


extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImage(newSize: CGSize) -> UIImage {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Returns a resized image that fits in rectSize, keeping it's aspect ratio
    /// Note that the new image size is not rectSize, but within it.
    func resizedImageWithinRect(rectSize: CGSize) -> UIImage {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize: newSize)
        return resized
    }
    
}


