//
//  LocationManager.swift
//  soulmate
//
//  Created by Richard Hsu on 11/21/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation
import CoreLocation

extension Coordinate
{
    init(location: CLLocation)
    {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}


// Location Manager is delegate to CLLocationManager

// expects a delegate that is a subclass of NSObject
final class LocationManager: NSObject, CLLocationManagerDelegate
{
    // need a location manager to ask for permission from the user
    let manager = CLLocationManager()
    
    var onLocationFix: (Coordinate -> Void)?
    
    
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
        // get location
        
        guard let location = locations.first else { return }
        
        
        print(location)
        
        let coordinate = Coordinate(location: location)
        
        if let onLocationFix = onLocationFix
        {
            onLocationFix(coordinate)
        }
    }
}
