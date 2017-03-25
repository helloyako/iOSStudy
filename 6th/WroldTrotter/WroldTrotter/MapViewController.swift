//
//  MapViewController.swift
//  WroldTrotter
//
//  Created by helloyako on 2017. 3. 22..
//  Copyright © 2017년 helloyako. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    var mapView: MKMapView!
    var currentLocationButton: UIButton!
    var locationManager: CLLocationManager!
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let margin = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margin.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        currentLocationButton = UIButton()
        currentLocationButton.isEnabled = false
        currentLocationButton.setTitleColor(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1), for: .normal)
        currentLocationButton.setTitle("Current Location", for: .normal)
        currentLocationButton.addTarget(self, action: #selector(MapViewController.currentLocationButtonClick(button:)), for: .touchUpInside)
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocationButton)
        
        let buttonBottomConstraint = currentLocationButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor)
        let buttonTrailingConstraint = currentLocationButton.trailingAnchor.constraint(equalTo: margin.trailingAnchor)
        
        buttonBottomConstraint.isActive = true
        buttonTrailingConstraint.isActive = true
    }
    
    func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    func currentLocationButtonClick(button: UIButton) {
        if let location = locationManager.location {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        print("MapViewController loaded its view.")
        
        mapView.delegate = self
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        currentLocationButton.isEnabled = true
    }
}
