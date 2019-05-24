//
//  EScooterMapViewController.swift
//  EScooters
//
//  Created by Sasi Moorthy on 23/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit
import MapKit

class MapPin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let tag: Int
    
    init(_ coordinate: CLLocationCoordinate2D, title: String, tag: Int) {
        self.coordinate = coordinate
        self.title = title
        self.tag = tag
        super.init()
    }
}

class EScooterMapViewController: UIViewController {
    
    @IBOutlet weak var eScooterMapView: MKMapView!
    
    var eScooterViewModel = EScooterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eScooterViewModel.updateHandler = { [weak self] in
            self?.locateEScooters()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerMapToBerlin()
        eScooterViewModel.fetchVehicles()
    }
    
    func locateEScooters() {
        eScooterMapView.removeAnnotations(eScooterMapView.annotations)
        let scootersCount = eScooterViewModel.getNumberOfScooters()
        for i in 0...scootersCount-1 {
            let eScooter = eScooterViewModel.getEScooter(atIndex: i)
            let scooterPin = MapPin(eScooter.coordinate, title: eScooter.description, tag: i+1)
            eScooterMapView.addAnnotation(scooterPin)
        }
    }
    
    func centerMapToBerlin() {
        // Center map in Berlin area since vehicle data is present in those regions alone
        let coordinate = CLLocationCoordinate2D(latitude: 52.52000, longitude: 13.4050)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        eScooterMapView.setRegion(mapRegion, animated: true)
    }
}

extension EScooterMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print((view.annotation as? MapPin)?.tag as Any)
    }
}
