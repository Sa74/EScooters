//
//  ViewController.swift
//  EScooters
//
//  Created by Sasi Moorthy on 22/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var eScooterViewModel = EScooterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eScooterViewModel.updateHandler = { [weak self] in
            print("Reload")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eScooterViewModel.fetchVehicles()
    }

}

