//
//  LocationManager.swift
//  soulmate
//
//  Created by Richard Hsu on 11/21/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation
import CoreLocation


// Location Manager is delegate to CLLocationManager

// expects a delegate that is a subclass of NSObject
final class LocationManager: NSObject, CLLocationManagerDelegate
{
    // need a location manager to ask for permission from the user
    let manager = CLLocationManager()
    
    
    override init()
    {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        
    }
    
    
    // create a function to get permission from the user
    func getPermission()
    {
        // check that authorization status is not given or determined
        if CLLocationManager.authorizationStatus() == .NotDetermined
        {
            manager.requestWhenInUseAuthorization()
        }
    
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse
        {
            manager.requestLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.description)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        <#code#>
    }
}
