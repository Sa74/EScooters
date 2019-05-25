//
//  EScooterDetailViewTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
@testable import EScooters

class EScooterDetailViewTests: XCTestCase {

    var eScooterDetailView: EScooterDetailView?
    var eScooterViewModel: EScooterViewModel?
    
    override func setUp() {
        let storyBoard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let scooterMapViewController: EScooterMapViewController = storyBoard.instantiateViewController(withIdentifier: "EScooterMapViewController") as! EScooterMapViewController
        scooterMapViewController.view.awakeFromNib()
        eScooterDetailView = scooterMapViewController.eScooterDetailView
        
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "response", ofType: "json") else { return }
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let eScooters = try! JSONDecoder().decode([EScooter].self, from: data)
        
        let mockEScooterService = MockEScooterService(eScooters)
        eScooterViewModel = EScooterViewModel(mockEScooterService)
        eScooterViewModel?.fetchVehicles()
        mockEScooterService.fetchSuccess()
    }

    override func tearDown() {
        eScooterDetailView = nil
        eScooterViewModel = nil
        super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(eScooterDetailView?.titleLabel.text, "")
        XCTAssertEqual(eScooterDetailView?.descriptionLabel.text, "")
        XCTAssertEqual(eScooterDetailView?.priceLabel.text, "")
        XCTAssertEqual(eScooterDetailView?.percentageLabel.text, "")
        XCTAssertEqual(eScooterDetailView?.bookButton.titleLabel?.text, "Book")
    }

    func testLoadEScooter() {
        
        var eScooterDetailModel = eScooterViewModel?.getEScooterDetailModel(forIndex: 3)
        eScooterDetailView?.loadScooterDetails(eScooterDetailModel!)
        
        XCTAssertEqual(eScooterDetailView?.titleLabel.text, "110000")
        XCTAssertEqual(eScooterDetailView?.descriptionLabel.text, "Electric Scooter")
        XCTAssertEqual(eScooterDetailView?.priceLabel.text, "€15 / 1h")
        XCTAssertEqual(eScooterDetailView?.percentageLabel.text, "3%")
        XCTAssertEqual(eScooterDetailView?.bookButton.titleLabel?.text, "Book")
        
        eScooterDetailModel = eScooterViewModel?.getEScooterDetailModel(forIndex: 4)
        eScooterDetailView?.loadScooterDetails(eScooterDetailModel!)
        
        XCTAssertEqual(eScooterDetailView?.titleLabel.text, "110011")
        XCTAssertEqual(eScooterDetailView?.descriptionLabel.text, "Electric Scooter")
        XCTAssertEqual(eScooterDetailView?.priceLabel.text, "€20 / 1h")
        XCTAssertEqual(eScooterDetailView?.percentageLabel.text, "45%")
        XCTAssertEqual(eScooterDetailView?.bookButton.titleLabel?.text, "Book")
    }

}
