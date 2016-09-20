//
//  ViewController.swift
//  soulmate
//
//  Created by Richard Hsu on 8/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var startLocation: CLLocation?
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /*
        let userLocation = CLLocation(latitude: 38.9075, longitude: -77.0365)
        let regionRadius: CLLocationDistance = 2000.0
        let region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, regionRadius, regionRadius)
 
        */
        
        let userLocation = UserLocation(name: "You", type: "You are here!", imageName: "yourLocation.png", latitude: 38.9075, longitude: -77.0365)
        //mapView.setRegion(region, animated: true)
        
        
        mapView.delegate = self
        mapView.mapType = .Standard
        mapView.rotateEnabled = false
        mapView.addAnnotation(userLocation)
        
        let regionRadius: CLLocationDistance = 15000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((userLocation.location.coordinate), regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // set up the locationManager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension ViewController: MKMapViewDelegate
{
    func mapViewWillStartRenderingMap(mapView: MKMapView)
    {
        print("rendering")
    }
}

// implement the CLLocationManagerDelegate protocol 
extension ViewController: CLLocationManagerDelegate
{
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil
        {
            startLocation = locations.first
            print(startLocation)
        }
        else
        {
            guard let latest = locations.first else { return }
            let distanceInMeters = startLocation?.distanceFromLocation(latest)
            print("distance in meters: \(distanceInMeters)")
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedWhenInUse || status == .AuthorizedAlways
        {
            locationManager?.startUpdatingLocation()
        }
    }
}




