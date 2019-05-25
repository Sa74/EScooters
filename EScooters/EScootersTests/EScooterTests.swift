//
//  EScooterTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
@testable import EScooters

class EScooterTests: XCTestCase {

    var eScootersData: Data?
    var eScooters: [EScooter]?
    
    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "response", ofType: "json") else { return }
        eScootersData = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    override func tearDown() {
        eScooters = nil
        super.tearDown()
    }
    
    func testEScooterData() {
        
        eScooters = try! JSONDecoder().decode([EScooter].self, from: eScootersData!)
        XCTAssertEqual(eScooters?.count, 6)
        
        var eScooter = eScooters![0]
        XCTAssertEqual(eScooter.id, 1)
        XCTAssertEqual(eScooter.name, "000011")
        XCTAssertEqual(eScooter.description, "Electric Scooter")
        XCTAssertEqual(eScooter.latitude, 52.529077)
        XCTAssertEqual(eScooter.longitude, 13.416351)
        XCTAssertEqual(eScooter.batteryLevel, 98)
        XCTAssertEqual(eScooter.timestamp, "2019-03-10T09:31:56Z")
        XCTAssertEqual(eScooter.price, 15)
        XCTAssertEqual(eScooter.priceTime, 60)
        XCTAssertEqual(eScooter.currency, "€")
        
        eScooter = eScooters![1]
        XCTAssertEqual(eScooter.id, 2)
        XCTAssertEqual(eScooter.name, "001100")
        XCTAssertEqual(eScooter.description, "Electric Scooter")
        XCTAssertEqual(eScooter.latitude, 52.529103)
        XCTAssertEqual(eScooter.longitude, 13.416255)
        XCTAssertEqual(eScooter.batteryLevel, 11)
        XCTAssertEqual(eScooter.timestamp, "2019-03-10T11:15:22Z")
        XCTAssertEqual(eScooter.price, 20)
        XCTAssertEqual(eScooter.priceTime, 60)
        XCTAssertEqual(eScooter.currency, "€")
        
        eScooter = eScooters![2]
        XCTAssertEqual(eScooter.id, 3)
        XCTAssertEqual(eScooter.name, "001111")
        XCTAssertEqual(eScooter.description, "Electric Scooter")
        XCTAssertEqual(eScooter.latitude, 52.531478)
        XCTAssertEqual(eScooter.longitude, 13.415641)
        XCTAssertEqual(eScooter.batteryLevel, 69)
        XCTAssertEqual(eScooter.timestamp, "2019-03-10T19:55:56Z")
        XCTAssertEqual(eScooter.price, 15)
        XCTAssertEqual(eScooter.priceTime, 60)
        XCTAssertEqual(eScooter.currency, "€")
        
        eScooter = eScooters![3]
        XCTAssertEqual(eScooter.id, 4)
        XCTAssertEqual(eScooter.name, "110000")
        XCTAssertEqual(eScooter.description, "Electric Scooter")
        XCTAssertEqual(eScooter.latitude, 52.536722)
        XCTAssertEqual(eScooter.longitude, 13.402195)
        XCTAssertEqual(eScooter.batteryLevel, 3)
        XCTAssertEqual(eScooter.timestamp, "2019-03-11T09:31:56Z")
        XCTAssertEqual(eScooter.price, 15)
        XCTAssertEqual(eScooter.priceTime, 60)
        XCTAssertEqual(eScooter.currency, "€")
    }
    
    func testEScooterCoordinate() {
        
        testEScooterData()
        
        var eScooter = eScooters![0]
        XCTAssertEqual(eScooter.coordinate.latitude, 52.529077)
        XCTAssertEqual(eScooter.coordinate.longitude, 13.416351)
        
        eScooter = eScooters![1]
        XCTAssertEqual(eScooter.coordinate.latitude, 52.529103)
        XCTAssertEqual(eScooter.coordinate.longitude, 13.416255)
        
        eScooter = eScooters![2]
        XCTAssertEqual(eScooter.coordinate.latitude, 52.531478)
        XCTAssertEqual(eScooter.coordinate.longitude, 13.415641)
        
        eScooter = eScooters![3]
        XCTAssertEqual(eScooter.coordinate.latitude, 52.536722)
        XCTAssertEqual(eScooter.coordinate.longitude, 13.402195)
    }
    
    func testEScooterEquatable() {
        
        testEScooterData()
        
        var eScooter1 = eScooters![0]
        var eScooter2 = eScooters![1]
        XCTAssertNotEqual(eScooter1, eScooter2)
        XCTAssertNotEqual(eScooter2, eScooter1)
        XCTAssertEqual(eScooter1, eScooter1)
        XCTAssertEqual(eScooter2, eScooter2)
        
        eScooter1 = eScooters![2]
        eScooter2 = eScooters![3]
        XCTAssertNotEqual(eScooter1, eScooter2)
        XCTAssertNotEqual(eScooter2, eScooter1)
        XCTAssertEqual(eScooter1, eScooter1)
        XCTAssertEqual(eScooter2, eScooter2)
    }
    
    func testEScooterDetailModel() {
        
        var eScooterDetail = EScooterDetailModel("1011", description: "Electric Scooter", priceDisplay: "€10 / 30min", batteryLevel: 10)
        
        XCTAssertEqual(eScooterDetail.title, "1011")
        XCTAssertEqual(eScooterDetail.description, "Electric Scooter")
        XCTAssertEqual(eScooterDetail.priceDisplay, "€10 / 30min")
        XCTAssertEqual(eScooterDetail.batteryLevel, 10)
        
        eScooterDetail = EScooterDetailModel("0011", description: "Electric Scooter", priceDisplay: "€20 / 45min", batteryLevel: 40)
        
        XCTAssertEqual(eScooterDetail.title, "0011")
        XCTAssertEqual(eScooterDetail.description, "Electric Scooter")
        XCTAssertEqual(eScooterDetail.priceDisplay, "€20 / 45min")
        XCTAssertEqual(eScooterDetail.batteryLevel, 40)
        
        eScooterDetail = EScooterDetailModel("1010", description: "Electric Scooter", priceDisplay: "€15 / 1h", batteryLevel: 80)
        
        XCTAssertEqual(eScooterDetail.title, "1010")
        XCTAssertEqual(eScooterDetail.description, "Electric Scooter")
        XCTAssertEqual(eScooterDetail.priceDisplay, "€15 / 1h")
        XCTAssertEqual(eScooterDetail.batteryLevel, 80)
    }
}
