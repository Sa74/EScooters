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
                self?.updateHandler()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
