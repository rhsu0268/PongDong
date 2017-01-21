//
//  LineChartFormatter.swift
//  PonMart
//
//  Created by Richard Hsu on 1/21/17.
//  Copyright © 2017 Richard Hsu. All rights reserved.
//

import Foundation
import Charts
import UIKit

public class LineChartFormatter: NSObject, IAxisValueFormatter
{
    var months: [String]! = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
}
