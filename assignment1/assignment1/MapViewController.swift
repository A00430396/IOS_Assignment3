//
//  MapViewController.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-27.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    
    var wonderLocation: CLLocation?
    var alternateLocation: CLLocation?
    var wonderName: String?
    var currentLocation: CLLocation?
    var alternateName: String?
    let manager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupMapView()
        setupLocationManager()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager.stopUpdatingLocation()
    }
    
    func setupMapView() {
        let coordinate = wonderLocation?.coordinate
        let alternateCoord = alternateLocation?.coordinate
        
        if let coordinate = coordinate, let name = wonderName, let altcoordinate = alternateCoord, let altName = alternateName {
            let annotation = MKPointAnnotation()
            let alternateAnnotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = coordinate
            
            alternateAnnotation.title = altName
            alternateAnnotation.coordinate = altcoordinate
            
            mapView.addAnnotation(annotation)
            mapView.addAnnotation(alternateAnnotation)
            zoom(annotation.coordinate)
        }
        mapView.showsUserLocation = true
    }
    
    func zoom(_ location: CLLocationCoordinate2D) {
        let radius = 1500
        let region = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(Double(radius) * 2.0), longitudinalMeters: CLLocationDistance(Double(radius) * 2.0))
        mapView.setRegion(region, animated: true)
    }
    
    func setupLocationManager() {
        if CLLocationManager.authorizationStatus() == .notDetermined{
            manager.requestWhenInUseAuthorization()
        }
        
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.delegate = self
        
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "reusePin")
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        if(annotation.title == wonderName){
            view.pinTintColor = UIColor.red
        } else{
        view.pinTintColor = UIColor.blue
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation
        let launchingOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        if let coordinate = view.annotation?.coordinate {
            let mapItem = location?.mapItem(coordinate: coordinate)
            mapItem?.openInMaps(launchOptions: launchingOptions)
        }
    }
}

extension MKAnnotation {
    func mapItem(coordinate: CLLocationCoordinate2D) -> MKMapItem {
        let placeMark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placeMark)
        return mapItem
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.currentLocation = location
        updateLocation(location)
    }
    
    private func updateLocation(_ currentLocation: CLLocation){
        self.currentLocation = currentLocation
    }
}
