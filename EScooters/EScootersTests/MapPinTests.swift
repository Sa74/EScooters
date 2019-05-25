//
//  MapPinTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
import MapKit
@testable import EScooters

class MapPinTests: XCTestCase {

    func testMapPinCreation() {
        
        var mapPin = MapPin(CLLocationCoordinate2D(latitude: 52.529077, longitude: 13.416351), title: "1011", tag: 1)
        XCTAssertEqual(mapPin.title, "1011")
        XCTAssertEqual(mapPin.coordinate.latitude, 52.529077)
        XCTAssertEqual(mapPin.coordinate.longitude, 13.416351)
        XCTAssertEqual(mapPin.tag, 1)
        
        mapPin = MapPin(CLLocationCoordinate2D(latitude: 52.529103, longitude: 13.416255), title: "0010", tag: 2)
        XCTAssertEqual(mapPin.title, "0010")
        XCTAssertEqual(mapPin.coordinate.latitude, 52.529103)
        XCTAssertEqual(mapPin.coordinate.longitude, 13.416255)
        XCTAssertEqual(mapPin.tag, 2)
        
        mapPin = MapPin(CLLocationCoordinate2D(latitude: 52.531478, longitude: 13.415641), title: "1001", tag: 3)
        XCTAssertEqual(mapPin.title, "1001")
        XCTAssertEqual(mapPin.coordinate.latitude, 52.531478)
        XCTAssertEqual(mapPin.coordinate.longitude, 13.415641)
        XCTAssertEqual(mapPin.tag, 3)
    }

}
