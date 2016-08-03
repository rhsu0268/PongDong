//
//  ViewController.swift
//  soulmate
//
//  Created by Richard Hsu on 8/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var startLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

extension ViewController: CLLocationManagerDelegate
{
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil
        {
            startLocation = locations.first
        }
        else
        {
            guard let latest = locations.first else { return }
            let distanceInMeters
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

