//
//  EScooter.swift
//  EScooters
//
//  Created by Sasi Moorthy on 23/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import Foundation
import MapKit

struct EScooter: Codable, Equatable {
    let id: Int
    let name: String
    let description: String
    let latitude: Double
    let longitude: Double
    let batteryLevel: Int
    let timestamp: String
    let price: Int
    let priceTime: Int
    let currency: String
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    }
    
    static func == (lhs: EScooter, rhs: EScooter) -> Bool {
        return lhs.id == rhs.id
    }
}

struct EScooterDetailModel: Codable {
    let title: String
    let description: String
    let priceDisplay: String
    let batteryLevel: Int
    
    init(_ title: String, description: String, priceDisplay: String, batteryLevel: Int) {
        self.title = title
        self.description = description
        self.priceDisplay = priceDisplay
        self.batteryLevel = batteryLevel
    }
}

