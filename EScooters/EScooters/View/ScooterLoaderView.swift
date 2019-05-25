//
//  ScooterLoaderView.swift
//  EScooters
//
//  Created by Sasi Moorthy on 25/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit

class ScooterLoaderView: UIView {
    
    private let containerView: UIView = UIView()
    private let scooterImageView = UIImageView(image: UIImage(named: "Loader"))
    private let scooterImageView2 = UIImageView(image: UIImage(named: "Loader"))
    let loadingLabel: UILabel = UILabel()
    
    override func awakeFromNib() {
        
        containerView.frame = bounds
        containerView.backgroundColor = UIColor.clear
        containerView.clipsToBounds = true
        
        loadingLabel.frame = CGRect(origin: CGPoint(x: 0, y: bounds.height - 10), size: CGSize(width: bounds.width, height: 8))
        loadingLabel.textColor = .white
        loadingLabel.font = UIFont.boldSystemFont(ofSize: 9)
        loadingLabel.text = "FIND"
        loadingLabel.textAlignment = .center
        containerView.addSubview(loadingLabel)
        
        setImageViewInitialFrames()
        containerView.addSubview(scooterImageView)
        containerView.addSubview(scooterImageView2)
        addSubview(containerView)
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.1
        layer.shadowRadius = 8
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 5.0
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 12)
        layer.shadowPath = path.cgPath
        
        backgroundColor = UIColor(red: 239.0/255.0, green:  33.0/255.0, blue:  14.0/255.0, alpha: 1.0)
    }
    
    func startAnimating() {
        loadingLabel.text = "FINDING"
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .curveLinear], animations: { [weak self] in
            if let loaderView: ScooterLoaderView = self {
                loaderView.scooterImageView.frame = loaderView.scooterImageView.frame.offsetBy(dx: loaderView.scooterImageView.frame.size.width, dy: 0.0)
                loaderView.scooterImageView2.frame = loaderView.scooterImageView2.frame.offsetBy(dx: loaderView.scooterImageView2.frame.size.width, dy: 0.0)
            }
        }, completion: nil)
    }
    
    func stopAnimating() {
        loadingLabel.text = "FIND"
        scooterImageView.layer.removeAllAnimations()
        scooterImageView2.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.scooterImageView.alpha = 0
            self?.scooterImageView2.alpha = 0
        }) { [weak self] (finished) in
            self?.scooterImageView.alpha = 1
            self?.scooterImageView2.alpha = 1
            self?.setImageViewInitialFrames()
        }
    }
    
    private func setImageViewInitialFrames() {
        scooterImageView.frame = CGRect(origin: CGPoint.zero, size: frame.size)
        scooterImageView2.frame = CGRect(origin: CGPoint(x: -frame.width, y: 0), size: frame.size)
    }
}
