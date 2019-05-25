//
//  EScooterViewModelTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
@testable import EScooters

class EScooterViewModelTests: XCTestCase {

    var eScooters: [EScooter]!
    var eScooterViewModel: EScooterViewModel!
    var mockEScooterService: MockEScooterService!
    
    override func setUp() {
        
        let testBundle = Bundle(for: type(of: self))
        
        guard let path = testBundle.path(forResource: "response", ofType: "json") else { return }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        eScooters = try! JSONDecoder().decode([EScooter].self, from: data)
        
        mockEScooterService = MockEScooterService(eScooters)
        eScooterViewModel = EScooterViewModel(mockEScooterService)
    }
    
    override func tearDown() {
        mockEScooterService.isVehicleFetchCalled = false
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertEqual(eScooterViewModel.getNumberOfScooters(), 0)
        XCTAssertEqual(eScooterViewModel.getAnnotations().count, 0)
    }
    
    func testVehicleFetchSuccess() {
        eScooterViewModel.fetchVehicles()
        XCTAssertTrue(mockEScooterService.isVehicleFetchCalled == true)
        mockEScooterService.fetchSuccess()
        
        XCTAssertEqual(eScooterViewModel.getNumberOfScooters(), 6)
        XCTAssertEqual(eScooterViewModel.getAnnotations().count, 6)
        XCTAssertEqual(eScooterViewModel.getEScooter(atIndex: 0), eScooters[0])
        XCTAssertEqual(eScooterViewModel.getEScooter(atIndex: 2), eScooters[2])
        XCTAssertNotNil(eScooterViewModel.getEScooterDetailModel(forIndex: 1))
    }
    
    func testVehicleFetchFailure() {
        eScooterViewModel.fetchVehicles()
        XCTAssertTrue(mockEScooterService.isVehicleFetchCalled == true)
        mockEScooterService.fetchFailure()
        
        XCTAssertEqual(eScooterViewModel.getNumberOfScooters(), 0)
        XCTAssertEqual(eScooterViewModel.getAnnotations().count, 0)
        
    }
    
    func testEScooterAtIndex() {
        testVehicleFetchSuccess()
        
        var eScooter = eScooterViewModel.getEScooter(atIndex: 0)
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
        
        eScooter = eScooterViewModel.getEScooter(atIndex: 2)
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
    }
    
    
    func testEScooterAnnotations() {
        
        testVehicleFetchSuccess()
        
        let annotations = eScooterViewModel.getAnnotations()
        XCTAssertEqual(annotations.count, 6)

        var annotation = annotations[0]
        XCTAssertEqual(annotation.coordinate.latitude, 52.529077)
        XCTAssertEqual(annotation.coordinate.longitude, 13.416351)
        XCTAssertEqual(annotation.title, "Electric Scooter")
        XCTAssertEqual(annotation.tag, 0)

        annotation = annotations[2]
        XCTAssertEqual(annotation.coordinate.latitude, 52.531478)
        XCTAssertEqual(annotation.coordinate.longitude, 13.415641)
        XCTAssertEqual(annotation.title, "Electric Scooter")
        XCTAssertEqual(annotation.tag, 2)

        annotation = annotations[5]
        XCTAssertEqual(annotation.coordinate.latitude, 52.523395)
        XCTAssertEqual(annotation.coordinate.longitude, 13.391386)
        XCTAssertEqual(annotation.title, "Electric Scooter")
        XCTAssertEqual(annotation.tag, 5)
    }
    
    func testEScooterDetailModel() {
        testVehicleFetchSuccess()
        
        var eScooterDetailModel = eScooterViewModel.getEScooterDetailModel(forIndex: 0)
        XCTAssertEqual(eScooterDetailModel.title, "000011")
        XCTAssertEqual(eScooterDetailModel.description, "Electric Scooter")
        XCTAssertEqual(eScooterDetailModel.priceDisplay, "€15 / 1h")
        XCTAssertEqual(eScooterDetailModel.batteryLevel, 98)
        
        eScooterDetailModel = eScooterViewModel.getEScooterDetailModel(forIndex: 1)
        XCTAssertEqual(eScooterDetailModel.title, "001100")
        XCTAssertEqual(eScooterDetailModel.description, "Electric Scooter")
        XCTAssertEqual(eScooterDetailModel.priceDisplay, "€20 / 1h")
        XCTAssertEqual(eScooterDetailModel.batteryLevel, 11)
        
        eScooterDetailModel = eScooterViewModel.getEScooterDetailModel(forIndex: 2)
        XCTAssertEqual(eScooterDetailModel.title, "001111")
        XCTAssertEqual(eScooterDetailModel.description, "Electric Scooter")
        XCTAssertEqual(eScooterDetailModel.priceDisplay, "€15 / 1h")
        XCTAssertEqual(eScooterDetailModel.batteryLevel, 69)
        
        eScooterDetailModel = eScooterViewModel.getEScooterDetailModel(forIndex: 3)
        XCTAssertEqual(eScooterDetailModel.title, "110000")
        XCTAssertEqual(eScooterDetailModel.description, "Electric Scooter")
        XCTAssertEqual(eScooterDetailModel.priceDisplay, "€15 / 1h")
        XCTAssertEqual(eScooterDetailModel.batteryLevel, 3)
    }
}

class MockEScooterService: EScooterService {
    
    var complete: ((Result) -> ())?
    var eScooters: [EScooter]!
    var isVehicleFetchCalled: Bool = false
    
    init(_ eScooters: [EScooter]) {
        self.eScooters = eScooters
    }
    
    override func fetchVehiclesList(completion: @escaping (Result) -> ()) {
        isVehicleFetchCalled = true
        complete = completion
    }
    
    func fetchSuccess() {
        complete!(Result.success(eScooters as Any))
    }
    
    func fetchFailure() {
        complete!(Result.failure("Invalid data"))
    }
}
