//
//  FirstViewController.swift
//  MapKitApp
//
//  Created by Valeria Karon on 1/26/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupPlacemark()
    }

    private func setupPlacemark() {
        let location: String = "96 Bd Bessières, 75017 Paris, France"
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

