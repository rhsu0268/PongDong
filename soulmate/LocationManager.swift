//
//  LocationManager.swift
//  soulmate
//
//  Created by Richard Hsu on 11/21/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationManager
{
    // need a location manager to ask for permission from the user
    let manager = CLLocationManager()
    
    
    // create a function to get permission from the user
    func getPermission()
    {
        // check that authorization status is not given or determined
        if CLLocationManager.authorizationStatus() == .NotDetermined
        {
            manager.requestWhenInUseAuthorization()
        }
    
    }
}
