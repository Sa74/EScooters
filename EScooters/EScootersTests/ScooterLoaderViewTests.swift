//
//  ScooterLoaderViewTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
@testable import EScooters

class ScooterLoaderViewTests: XCTestCase {

    let scooterLoaderView = ScooterLoaderView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
    
    override func setUp() {
        scooterLoaderView.awakeFromNib()
    }
    
    func testInit() {
        XCTAssertEqual(scooterLoaderView.subviews.count, 1)
        XCTAssertEqual(scooterLoaderView.loadingLabel.text, "FIND")
    }
    
    func testStartAnimating() {
        scooterLoaderView.startAnimating()
        XCTAssertEqual(scooterLoaderView.loadingLabel.text, "FINDING")
    }
    
    func testStopAnimating() {
        scooterLoaderView.stopAnimating()
        XCTAssertEqual(scooterLoaderView.loadingLabel.text, "FIND")
    }
}
