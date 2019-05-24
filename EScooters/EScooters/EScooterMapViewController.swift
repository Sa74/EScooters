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
    @IBOutlet weak var eScooterDetailView: EScooterDetailView!
    @IBOutlet weak var eScooterDetailViewBottom: NSLayoutConstraint!
    
    var eScooterViewModel = EScooterViewModel()
    var selectedScooterIndex: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eScooterViewModel.updateHandler = { [weak self] in
            self?.locateEScooters()
        }
        hideScooterDetailView(false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        centerMapToBerlin()
        eScooterViewModel.fetchVehicles()
    }
    
    func locateEScooters() {
        eScooterMapView.removeAnnotations(eScooterMapView.annotations)
        eScooterMapView.showAnnotations(eScooterViewModel.getAnnotations(), animated: true)
    }
    
    func centerMapToBerlin() {
        // Center map in Berlin area since vehicle data is present in those regions alone
        let coordinate = CLLocationCoordinate2D(latitude: 52.52000, longitude: 13.4050)
        let mapRegion = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        eScooterMapView.setRegion(mapRegion, animated: true)
    }
}


extension EScooterMapViewController {
    
    func displayScooterDetailView(_ animated: Bool, delayed: Bool) {
        let duration = (animated) ? 0.5 : 0
        let delay = (delayed) ? 0.6 : 0
        translateScooterDetailView(duration, delay: delay, bottom: 70, transform: CGAffineTransform(scaleX: 1.0, y: 1.0))
    }
    
    func hideScooterDetailView(_ animated: Bool) {
        let duration = (animated) ? 0.5 : 0
        translateScooterDetailView(duration, delay: 0, bottom: -50, transform: CGAffineTransform(scaleX: 0.1, y: 0.1))
    }
    
    private func translateScooterDetailView(_ duration: Double, delay: Double, bottom: CGFloat, transform: CGAffineTransform) {
        eScooterDetailViewBottom.constant = bottom
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.eScooterDetailView.transform = transform
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}


extension EScooterMapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var scooterPin = mapView.dequeueReusableAnnotationView(withIdentifier: "ScooterPin")
        if scooterPin == nil {
            scooterPin = MKAnnotationView(annotation: annotation, reuseIdentifier: "ScooterPin")
        }
        scooterPin?.annotation = annotation
        scooterPin?.isEnabled = true
        scooterPin?.image = UIImage(named: "Pin")
        return scooterPin
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        view.image = UIImage(named: "ScaledPin")
        guard let selectedIndex = (view.annotation as? MapPin)?.tag else {
            fatalError("Invalid annotation index found")
        }
        eScooterDetailView.loadScooterDetails(eScooterViewModel.getEScooterDetailModel(forIndex: selectedIndex))
        if (selectedScooterIndex == -1) {
            displayScooterDetailView(true, delayed: true)
        }
        selectedScooterIndex = selectedIndex
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage(named: "Pin")
        DispatchQueue.main.async { [weak self] in
            self?.delayedDeselect(view: view)
        }
    }
    
    func delayedDeselect(view: MKAnnotationView) {
        let deselctedIndex = (view.annotation as? MapPin)?.tag
        if selectedScooterIndex == deselctedIndex {
            hideScooterDetailView(true)
            selectedScooterIndex = -1
        }
    }
}
