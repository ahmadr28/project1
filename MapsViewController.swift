
//  MapsViewController.swift
//  SmartCameraLBTA
//
//  Created by Ikhtiar Alam on 4/25/19.
//

import Foundation
import MapKit
import CoreLocation
struct Pizza {
    var name: String
    var lattitude: CLLocationDegrees
    var longtitude: CLLocationDegrees
}
class MapsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    // 32.844516, -96.787445 Pizza Hut
    // 32.866317, -96.788381 Mimi's Pizza
    //32.832200, -96.770505 Piggie's Pies
    //32.814422, -96.770568 Greenville Aveune Pizza
    // 32.837205, -96.751164 - Olivella's Pizza
    let pizza = [Pizza(name: "Pizza Hut", lattitude: 32.844516, longtitude: -96.787445),
                 Pizza(name: "Mimi's Pizza", lattitude: 32.866317, longtitude:  -96.788381),
                 Pizza(name: "Piggie's PIes", lattitude: 32.832200, longtitude: -96.770505),
                 Pizza(name: "Greenville Avenue Pizza", lattitude: 32.814422, longtitude: -96.770568),
                 Pizza(name: "Top Pot Doughnuts", lattitude: 32.867826, longtitude: -96.751164)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.mapView.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
        checkLocationServices()
        fetchPizzaOnMap(pizza)
    }
    
    internal func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        let region = MKCoordinateRegion(center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            self.mapView.setRegion(region, animated: true)
    }
    
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
        }
    }
    
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            
        // For these case, you need to show a pop-up telling users what's up and how to turn on permisneeded if needed
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func fetchPizzaOnMap(_ stadiums: [Pizza]) {
        for pizza in pizza {
            let annotations = MKPointAnnotation()
            annotations.title = pizza.name
            annotations.coordinate = CLLocationCoordinate2D(latitude: pizza.lattitude, longitude: pizza.longtitude)
            mapView.addAnnotation(annotations)
        }
    }
}
