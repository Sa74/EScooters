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
    @IBOutlet weak var eScooterDetailView: EScooterDetailView!
    @IBOutlet weak var eScooterDetailViewBottom: NSLayoutConstraint!
    @IBOutlet weak var eScooterLoaderView: ScooterLoaderView!
    
    var eScooterViewModel = EScooterViewModel()
    var selectedAnnotation: MapPin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eScooterViewModel.updateHandler = { [weak self] in
            self?.locateEScooters()
        }
        hideScooterDetailView(false)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scooterLoaderViewTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        eScooterLoaderView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eScooterViewModel.fetchVehicles()
    }
    
    func locateEScooters() {
        eScooterLoaderView.stopAnimating()
        eScooterMapView.removeAnnotations(eScooterMapView.annotations)
        eScooterMapView.showAnnotations(eScooterViewModel.getAnnotations(), animated: true)
    }
    
    func centerMap(toCoordinate coordinate: CLLocationCoordinate2D) {
        let point = MKMapPoint(coordinate)
        var rect = eScooterMapView.visibleMapRect
        rect.origin.x = point.x - rect.size.width * 0.5
        rect.origin.y = point.y - rect.size.height * 0.5
        eScooterMapView.setVisibleMapRect(rect, animated: true)
    }
    
    @objc func scooterLoaderViewTapped() {
        if let annotation = selectedAnnotation {
            eScooterMapView.deselectAnnotation(annotation, animated: true)
        }
        eScooterLoaderView.startAnimating()
        eScooterViewModel.fetchVehicles()
    }
}


extension EScooterMapViewController {
    
    func displayScooterDetailView(_ animated: Bool, delayed: Bool) {
        let duration = (animated) ? 0.25 : 0
        let delay = (delayed) ? 0.4 : 0
        translateScooterDetailView(duration, delay: delay, bottom: 70, transform: CGAffineTransform(scaleX: 1.0, y: 1.0))
    }
    
    func hideScooterDetailView(_ animated: Bool) {
        let duration = (animated) ? 0.25 : 0
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
        guard let annotaion = view.annotation as? MapPin else {
            fatalError("Invalid annotation found")
        }
        eScooterDetailView.loadScooterDetails(eScooterViewModel.getEScooterDetailModel(forIndex: annotaion.tag))
        if (selectedAnnotation == nil) {
            displayScooterDetailView(true, delayed: true)
        }
        selectedAnnotation = annotaion
        centerMap(toCoordinate: view.annotation!.coordinate)
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.image = UIImage(named: "Pin")
        DispatchQueue.main.async { [weak self] in
            self?.delayedDeselect(view: view)
        }
    }
    
    func delayedDeselect(view: MKAnnotationView) {
        guard let annotaion = view.annotation as? MapPin else {
            fatalError("Invalid annotation found")
        }
        if selectedAnnotation == annotaion {
            hideScooterDetailView(true)
            selectedAnnotation = nil
            eScooterMapView.showAnnotations(eScooterMapView.annotations, animated: true)
        }
    }
}
