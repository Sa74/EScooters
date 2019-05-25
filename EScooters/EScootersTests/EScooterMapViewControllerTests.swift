//
//  EScooterMapViewControllerTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
@testable import EScooters

class EScooterMapViewControllerTests: XCTestCase {

    var mockEScooterViewModel: MockEScooterViewModel?
    var mockEScooterService: MockEScooterService?
    var scooterMapViewController: EScooterMapViewController?
    
    override func setUp() {
        
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "response", ofType: "json") else { return }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let eScooters = try! JSONDecoder().decode([EScooter].self, from: data)
        mockEScooterService = MockEScooterService(eScooters)
        mockEScooterViewModel = MockEScooterViewModel(mockEScooterService!)
        
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        scooterMapViewController = storyBoard.instantiateViewController(withIdentifier: "EScooterMapViewController") as? EScooterMapViewController
        scooterMapViewController?.view.awakeFromNib()
        
        scooterMapViewController?.eScooterViewModel = mockEScooterViewModel!
        mockEScooterViewModel!.updateHandler = { [weak scooterMapViewController] in
            scooterMapViewController?.locateEScooters()
        }
    }

    override func tearDown() {
        mockEScooterViewModel = nil
        mockEScooterService = nil
        scooterMapViewController = nil
        super.tearDown()
    }
    
    func testInit() {
        XCTAssertEqual(scooterMapViewController?.eScooterMapView.annotations.count, 0)
        XCTAssertNil(scooterMapViewController?.selectedAnnotation)
        XCTAssertNotNil(scooterMapViewController?.eScooterViewModel)
        XCTAssertNotNil(scooterMapViewController?.eScooterMapView)
        XCTAssertNotNil(scooterMapViewController?.eScooterDetailView)
        XCTAssertNotNil(scooterMapViewController?.eScooterLoaderView)
    }
    
    func testViewDidAppear() {
        scooterMapViewController?.viewDidAppear(true)
        XCTAssertEqual(mockEScooterViewModel!.isFetchCalled, true)
        XCTAssertEqual(mockEScooterService!.isVehicleFetchCalled, true)
    }
    
    func testFetchSuccess() {
        scooterMapViewController?.scooterLoaderViewTapped()
        XCTAssertEqual(mockEScooterViewModel!.isFetchCalled, true)
        XCTAssertEqual(mockEScooterService!.isVehicleFetchCalled, true)
        mockEScooterService?.fetchSuccess()
        
        XCTAssertEqual(scooterMapViewController!.eScooterMapView.annotations.count, 6)
        XCTAssertNil(scooterMapViewController?.selectedAnnotation)
    }
    
    func testFetchFailure() {
        scooterMapViewController?.scooterLoaderViewTapped()
        XCTAssertEqual(mockEScooterViewModel!.isFetchCalled, true)
        XCTAssertEqual(mockEScooterService!.isVehicleFetchCalled, true)
        mockEScooterService?.fetchFailure()
        
        XCTAssertEqual(scooterMapViewController!.eScooterMapView.annotations.count, 0)
        XCTAssertNil(scooterMapViewController?.selectedAnnotation)
    }
}

class MockEScooterViewModel: EScooterViewModel {
    
    var isSuccess = true
    var isFetchCalled = false
    
    override func fetchVehicles() {
        isFetchCalled = true
        super.fetchVehicles()
    }
    
    override func getNumberOfScooters() -> Int {
        return (isSuccess) ? super.getNumberOfScooters() : 0
    }
    
    override func getAnnotations() -> [MapPin] {
        return (isSuccess) ? super.getAnnotations() : []
    }
    
    override func getEScooter(atIndex index: Int) -> EScooter {
        let eScooter = EScooter(id: 0, name: "", description: "", latitude: 0, longitude: 0, batteryLevel: 0, timestamp: "", price: 0, priceTime: 0, currency: "")
        return (isSuccess) ? super.getEScooter(atIndex: index) : eScooter
    }

    override func getEScooterDetailModel(forIndex index: Int) -> EScooterDetailModel {
        let eScooterDetail = EScooterDetailModel("", description: "", priceDisplay: "", batteryLevel: 0)
        return (isSuccess) ? super.getEScooterDetailModel(forIndex: index) : eScooterDetail
    }
}
