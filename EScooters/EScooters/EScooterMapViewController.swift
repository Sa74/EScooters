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
        
        // Center map in Berlin area since vehicle data is present in those regions alone
        let coordinate = CLLocationCoordinate2D(latitude: 52.52000, longitude: 13.4050)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        eScooterMapView.setRegion(mapRegion, animated: true)
        
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
