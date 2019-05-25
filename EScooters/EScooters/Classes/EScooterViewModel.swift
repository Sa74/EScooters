//
//  EScooterViewModel.swift
//  EScooters
//
//  Created by Sasi Moorthy on 23/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import Foundation

class EScooterViewModel {
    
    private let eScooterService: EScooterService!
    private var eScooters: [EScooter]?
    
    /*
     * The closure that will get called every time
     * when the view model is updated
     */
    var updateHandler: () -> Void = {}
    
    init(_ eScooterService: EScooterService = EScooterService()) {
        self.eScooterService = eScooterService
    }
}


extension EScooterViewModel {
    
    func fetchVehicles() {
        eScooterService.fetchVehiclesList { [weak self] (result) in
            switch result {
            case .success(let eScooterResult):
                guard let eScooters = eScooterResult as? [EScooter] else {
                    fatalError("Invalid response from EScooterService")
                }
                self?.eScooters = eScooters
                
            case .failure(let error):
                WarningManager.createAndPushWarning(message: "\(error)", cancel: "Ok")
            }
            self?.updateHandler()
        }
    }
    
    func getNumberOfScooters() -> Int {
        return eScooters?.count ?? 0
    }
    
    func getEScooter(atIndex index: Int) -> EScooter {
        guard let eScooter = eScooters?[index] else {
            fatalError("Invalid index for EScooters")
        }
        return eScooter
    }
    
    func getAnnotations() -> [MapPin] {
        guard let eScooters = eScooters else {
            return []
        }
        var annotations = [MapPin]()
        for eScooter in eScooters {
            let scooterPin = MapPin(eScooter.coordinate, title: eScooter.description, tag: eScooters.firstIndex(of: eScooter)!)
            annotations.append(scooterPin)
        }
        return annotations
    }
    
    func getEScooterDetailModel(forIndex index: Int) -> EScooterDetailModel {
        guard let eScooter = eScooters?[index] else {
            fatalError("Invalid index for EScooterDetailModel")
        }
        
        let timeString = TimeFormatter.minutesToHoursMinutesString(minutes: eScooter.priceTime)
        let priceDisplay = "\(eScooter.currency)\(eScooter.price) / \(timeString)"
        let eScooterDetailModel = EScooterDetailModel(eScooter.name, description: eScooter.description, priceDisplay: priceDisplay, batteryLevel: eScooter.batteryLevel)
        return eScooterDetailModel
    }
}
