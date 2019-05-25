//
//  TimeFormatterTests.swift
//  EScootersTests
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import XCTest
@testable import EScooters

class TimeFormatterTests: XCTestCase {

    func testMinutesToHoursMinutesString() {
        var timeString = TimeFormatter.minutesToHoursMinutesString(minutes: 80)
        XCTAssertEqual(timeString, "1h 20min")
        
        timeString = TimeFormatter.minutesToHoursMinutesString(minutes: 40)
        XCTAssertEqual(timeString, "40min")
        
        timeString = TimeFormatter.minutesToHoursMinutesString(minutes: 60)
        XCTAssertEqual(timeString, "1h")
        
        timeString = TimeFormatter.minutesToHoursMinutesString(minutes: 130)
        XCTAssertEqual(timeString, "2h 10min")
    }
    
    func testGetTimeString() {
        var timeString = TimeFormatter.getTimeString(1, minute: 0)
        XCTAssertEqual(timeString, "1h")
        
        timeString = TimeFormatter.getTimeString(0, minute: 0)
        XCTAssertEqual(timeString, "")
        
        timeString = TimeFormatter.getTimeString(0, minute: 20)
        XCTAssertEqual(timeString, "20min")
        
        timeString = TimeFormatter.getTimeString(1, minute: 10)
        XCTAssertEqual(timeString, "1h 10min")
    }
    
    func testMinutesToHoursMinutes() {
        var (h, m) = TimeFormatter.minutesToHoursMinutes(minutes: 45)
        XCTAssertEqual(h, 0)
        XCTAssertEqual(m, 45)
        
        (h, m) = TimeFormatter.minutesToHoursMinutes(minutes: 75)
        XCTAssertEqual(h, 1)
        XCTAssertEqual(m, 15)
        
        (h, m) = TimeFormatter.minutesToHoursMinutes(minutes: 125)
        XCTAssertEqual(h, 2)
        XCTAssertEqual(m, 5)
    }

}
