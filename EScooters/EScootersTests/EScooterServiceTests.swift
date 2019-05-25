//
//  EScooterServiceTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
@testable import EScooters

class EScooterServiceTests: XCTestCase {

    var eScooterService: EScooterService?
    let mockService = MockApiService()
    
    override func setUp() {
        super.setUp()
        eScooterService = EScooterService(mockService)
    }
    
    override func tearDown() {
        eScooterService = nil
        super.tearDown()
    }
    
    func testVehicleFetchSuccess() {
        eScooterService?.fetchVehiclesList(completion: { (result) in
            switch result {
            case .success(let scooterResut):
                let eScooters = scooterResut as? [EScooter]
                XCTAssertNotNil(eScooters)
                XCTAssertEqual(eScooters?.count, 6)
                
                var eScooter = eScooters![0]
                XCTAssertEqual(eScooter.id, 1)
                XCTAssertEqual(eScooter.name, "000011")
                
                eScooter = eScooters![1]
                XCTAssertEqual(eScooter.id, 2)
                XCTAssertEqual(eScooter.name, "001100")
                
                eScooter = eScooters![2]
                XCTAssertEqual(eScooter.id, 3)
                XCTAssertEqual(eScooter.name, "001111")
                
            case .failure( _):
                XCTFail("Invalid response")
            }
        })
        mockService.callSuccess()
    }
    
    func testVehicleFetchFailure() {
        eScooterService?.fetchVehiclesList(completion: { (result) in
            switch result {
            case .success( _):
                XCTFail("Invalid response")
                
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        })
        mockService.callFailure()
    }
}

class MockApiService: ApiService {
    
    var complete: ((Data?, Error?) -> ())!
    
    override func fetchData(url: String, completion: @escaping (_ responseData: Data?, _ error: Error?) -> Void) {
        self.complete = completion
    }
    
    func callSuccess() {
        guard let path = Bundle.main.path(forResource: "response", ofType: "json") else { return }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        complete(data, nil)
    }
    
    func callFailure() {
        complete(nil, NSError(domain:"", code:-1101, userInfo:["description": "Mock service failure"]))
    }
}
