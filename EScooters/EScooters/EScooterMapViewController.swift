//
//  EScooterMapViewController.swift
//  EScooters
//
//  Created by Sasi Moorthy on 23/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit
import MapKit

class EScooterMapViewController: UIViewController {
    
    @IBOutlet weak var eScooterMapView: MKMapView!
    
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

extension EScooterMapViewController: MKMapViewDelegate {
    
}
