//
//  MapPin.swift
//  EScooters
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let tag: Int
    
    init(_ coordinate: CLLocationCoordinate2D, title: String, tag: Int) {
        self.coordinate = coordinate
        self.title = title
        self.tag = tag
        super.init()
    }
    
    static func == (lhs: MapPin, rhs: MapPin) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}
