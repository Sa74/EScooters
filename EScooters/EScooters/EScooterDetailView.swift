//
//  EScooterDetailView.swift
//  EScooters
//
//  Created by Sasi Moorthy on 24/05/19.
//  Copyright © 2019 Sasi Moorthy. All rights reserved.
//

import UIKit

class BatteryView: UIView {
    
    @IBOutlet weak var batteryHead: UIView!
    
    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 2.0
        backgroundColor = .white
        
        batteryHead.layer.cornerRadius = 1.0
        batteryHead.layer.borderColor = UIColor.darkGray.cgColor
        batteryHead.layer.borderWidth = 2.0
        batteryHead.backgroundColor = .white
    }
    
    func showPercentage(_ percentage: Int) {
        resetPercentage()
        layer.borderWidth = 0.5
        let levelLayer = CAShapeLayer()
        levelLayer.path = UIBezierPath(roundedRect: CGRect(x: 0,
                                                           y: 0,
                                                           width: frame.width * (CGFloat(percentage) / 100.0),
                                                           height: frame.height),
                                       cornerRadius: 0).cgPath
        levelLayer.fillColor = (percentage <= 20) ? UIColor.red.cgColor : UIColor.green.cgColor
        layer.addSublayer(levelLayer)
    }
    
    func resetPercentage() {
        let levelLayer = CAShapeLayer()
        levelLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 0).cgPath
        levelLayer.fillColor = UIColor.white.cgColor
        layer.addSublayer(levelLayer)
    }
}

class EScooterDetailView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var batteryView: BatteryView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 15
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.1
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowOpacity = 1.0
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 12)
        layer.shadowPath = path.cgPath
        
        titleLabel.text = ""
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        descriptionLabel.text = ""
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)
        descriptionLabel.textColor = .darkGray
        priceLabel.text = ""
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        priceLabel.textColor = .black
        percentageLabel.text = ""
        percentageLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.textColor = .black
        
        bookButton.backgroundColor = UIColor.blue
        bookButton.layer.cornerRadius = bookButton.frame.height / 2
        bookButton.setTitleColor(UIColor.white, for: .normal)
        bookButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    func loadScooterDetails(_ eScooterDetail: EScooterDetailModel) {
        shake(0.4)
        titleLabel.text = eScooterDetail.title
        descriptionLabel.text = eScooterDetail.description
        priceLabel.text = eScooterDetail.priceDisplay
        percentageLabel.text = "\(eScooterDetail.batteryLevel)%"
        batteryView.showPercentage(eScooterDetail.batteryLevel)
    }
}

extension UIView {
    func shake(_ duration: Double) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = duration
        animation.values = [-15.0, 15.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}
