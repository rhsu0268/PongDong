//
//  UserLocation.swift
//  soulmate
//
//  Created by Richard Hsu on 8/3/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import UIKit
import MapKit

class UserLocation: NSObject
{
    let name: String
    let type: String
    let location: CLLocation
    let image: UIImage?
    
    init(name: String, type: String, imageName: String, latitude: Double, longitude: Double)
    {
        self.name = name
        self.type = type
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.image = UIImage(named: imageName)
    }
}

// create an extension that implements the MKAnnotation protocol
extension UserLocation: MKAnnotation
{
    var coordinate: CLLocationCoordinate2D
    {
        get
        {
            return location.coordinate
        }
    }
    var title: String?
    {
        get
        {
            return name
        }
    }
    var subtitle: String?
    {
        get
        {
            return type
        }
    }
    
}