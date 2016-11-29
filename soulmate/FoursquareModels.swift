//
//  FoursquareModels.swift
//  soulmate
//
//  Created by Richard Hsu on 11/2/16.
//  Copyright © 2016 Richard Hsu. All rights reserved.
//

import Foundation

struct Coordinate
{
    let latitude: Double
    let longitude: Double
}

// get a string out of coordinate
extension Coordinate: CustomStringConvertible
{
    var description: String
    {
        return "\(latitude),\(longitude)"
    }
}
