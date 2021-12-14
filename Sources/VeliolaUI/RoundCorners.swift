//
//  File.swift
//  
//
//  Created by Tadreik Campbell on 10/15/21.
//

import UIKit

extension UIView {
    public func roundCorners(_ radius: Float, withShadow: Bool = true) {
        if withShadow {
            layer.masksToBounds = false
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: CGFloat(radius)).cgPath
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: 0, height: 1)
            layer.shadowRadius = 2
        } else {
            layer.masksToBounds = true
        }
        layer.cornerRadius = CGFloat(radius)
    }
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func pinToTop(ofView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}
