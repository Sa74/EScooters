//
//  EScooter.swift
//  EScooters
//
//  Created by Sasi Moorthy on 23/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import Foundation

struct EScooter: Codable {
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
}

