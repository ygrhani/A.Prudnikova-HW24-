//
//  UIButton + Extension .swift
//  A. Prudnikova (HW24)
//
//  Created by Ann Prudnikova on 27.12.22.
//

import Foundation
import UIKit

extension UIButton {
    func setGradient(button: UIButton) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPointMake(0.2, 0.8)
        gradientLayer.endPoint = CGPointMake(0.8, 0.2)
        gradientLayer.colors = [
            UIColor.systemPurple.cgColor,
            UIColor.systemMint.cgColor
        ]
        gradientLayer.frame = self.bounds
        gradientLayer.opacity = 0.88
        gradientLayer.cornerRadius = 17
        gradientLayer.borderWidth = 1
        gradientLayer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .clear
        self.titleLabel?.alpha = 1
        self.layer.addSublayer(gradientLayer)
    }
}

