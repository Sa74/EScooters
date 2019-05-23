//
//  ViewController.swift
//  EScooters
//
//  Created by Sasi Moorthy on 22/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let eScooterService = EScooterService()
        eScooterService.fetchVehiclesList { (result) in
            print(result)
        }
    }


}

