//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by helloyako on 2016. 7. 18..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var currentLocationButton: UIButton!
    
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        
        
        let segmentedControl = UISegmentedControl(items: ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), forControlEvents: .ValueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        topConstraint.active = true
        leadingConstraint.active = true
        trailingConstraint.active = true
        
        
        currentLocationButton = UIButton()
        currentLocationButton.setTitle("Current Location", forState: UIControlState.Disabled)
        currentLocationButton.addTarget(self, action: #selector(MapViewController.currentLocationButtonClick(_:)), forControlEvents: .TouchUpInside)
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocationButton)

        let buttonBottomConstraint = currentLocationButton.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor)
        let buttonTrailingConstraint = currentLocationButton.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor)
        
        buttonBottomConstraint.active = true
        buttonTrailingConstraint.active = true
    }
    
    func currentLocationButtonClick(button: UIButton) {
        if let location = locationManager.location {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
            self.mapView.showsUserLocation = true
        }
        
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        currentLocationButton.setTitle("Current Location", forState: UIControlState.Normal)
        currentLocationButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
}
