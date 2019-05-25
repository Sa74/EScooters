//
//  TimeFormatter.swift
//  EScooters
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import Foundation

class TimeFormatter {
    
    class func minutesToHoursMinutesString(minutes : Int) -> String {
        let (h, m) = TimeFormatter.minutesToHoursMinutes(minutes: minutes)
        return TimeFormatter.getTimeString(h, minute: m)
    }
    
    class func getTimeString(_ hour:Int, minute: Int) -> String {
        let hourString = (hour > 0) ? "\(hour)h" : ""
        let minuteString = (minute > 0) ? "\(minute)min" : ""
        return "\(hourString) \(minuteString)"
    }
    
    class func minutesToHoursMinutes (minutes : Int) -> (Int, Int) {
        return (minutes / 60, minutes % 60)
    }
}
