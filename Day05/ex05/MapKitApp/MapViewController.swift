//
//  FirstViewController.swift
//  MapKitApp
//
//  Created by Valeria Karon on 1/26/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    let locationManager = CLLocationManager()
    let regionInMeters = 10_000.00
    var locationString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        checkLocationServices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupPlacemark()
    }

    private func setupPlacemark() {
        let location: String = locationString ?? "96 Bd Bessières, 75017 Paris, France"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location){(placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            let annotation = MKPointAnnotation()
            annotation.title = "42"
            annotation.subtitle = "Ecole trop style"
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            self.mapView.showAnnotations([annotation], animated: true)
        }
    }
    
    private func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            showAlert(
                title: "Location services are disabled",
                message: "To enable it go: Setting ->Privacy->Location services and turn On")
        }
    }
    
    private func showAlert(title: String, message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(OKAction)
            self.present(alert, animated: true)
        }
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            break
        case .denied:
            showAlert(
            title: "Location services are disabled",
            message: "To enable it go: Setting ->Privacy->Location services and turn On")
            break
        case .restricted:
            showAlert(
            title: "Location services are disabled",
            message: "To enable it go: Setting ->Privacy->Location services and turn On")
            break
        case .authorizedAlways:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            print("new branch in CLLocationManager.authorizationStatus()")
        }
    }
    
    @IBAction func ChoiseSegment(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 1: mapView.mapType = .satellite
        case 2: mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
        
    }
    
    @IBAction func centerUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(
                center: location,
                latitudinalMeters: regionInMeters,
                longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) ->
        MKAnnotationView? {
        
        let annotationIdentifier = "annotationIdentifier"
            
        var annotationVew = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        
        if annotationVew == nil {
            annotationVew = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationVew?.canShowCallout = true
        }
        
        return annotationVew
    }
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
