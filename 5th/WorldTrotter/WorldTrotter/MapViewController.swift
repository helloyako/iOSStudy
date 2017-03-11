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
    var currentPinIndex = 0
    var pinCoordinateArray:[CLLocationCoordinate2D]!
    
    
    override func loadView() {
        mapView = MKMapView()
        mapView.delegate = self
        view = mapView
        
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let hybriddString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        
        let segmentedControl = UISegmentedControl(items: [standardString, hybriddString, satelliteString])
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
        
        let nextPinButton = UIButton()
        nextPinButton.setTitle("Next Pin", forState: UIControlState.Normal)
        nextPinButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        nextPinButton.addTarget(self, action: #selector(MapViewController.netxPinButtonClick(_:)), forControlEvents: .TouchUpInside)
        nextPinButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextPinButton)
        
        nextPinButton.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        nextPinButton.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
    }
    
    func netxPinButtonClick(button: UIButton) {
        currentPinIndex = (currentPinIndex % pinCoordinateArray.count)
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(pinCoordinateArray[currentPinIndex], MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView.setRegion(theRegion, animated: true)
        currentPinIndex = currentPinIndex + 1
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
            
            pinCoordinateArray = Array()

            //birth place Pin
            let birthLatitude: CLLocationDegrees = 37.548056
            let birthLongitude: CLLocationDegrees = 127.102605
            let birthCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(birthLatitude, birthLongitude)
            let birthPinAnnotation = MKPointAnnotation()
            birthPinAnnotation.coordinate = birthCoordinate
            birthPinAnnotation.title = "birth place"
            self.mapView.addAnnotation(birthPinAnnotation)
            pinCoordinateArray.append(birthCoordinate)
            
            
            //my location Pin
            if let location = locationManager.location {
                let myLatitude: CLLocationDegrees = location.coordinate.latitude
                let myLongitude: CLLocationDegrees = location.coordinate.longitude
                let myCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(myLatitude, myLongitude)
                let myPinAnnotation = MKPointAnnotation()
                myPinAnnotation.coordinate = myCoordinate
                myPinAnnotation.title = "my location"
                self.mapView.addAnnotation(myPinAnnotation)
                pinCoordinateArray.append(myCoordinate)
            }
            
            //interesting place pin
            let interestingLatitude: CLLocationDegrees = 10.308176
            let interestingLongitude: CLLocationDegrees = 124.020091
            let interestingCoordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(interestingLatitude, interestingLongitude)
            let interestingPinAnnotation = MKPointAnnotation()
            interestingPinAnnotation.coordinate = interestingCoordinate
            interestingPinAnnotation.title = "interesting place"
            self.mapView.addAnnotation(interestingPinAnnotation)
            pinCoordinateArray.append(interestingCoordinate)
        }
    }
    
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        currentLocationButton.setTitle("Current Location", forState: UIControlState.Normal)
        currentLocationButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
}
