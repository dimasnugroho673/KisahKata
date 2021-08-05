//
//  CustomStoryProgressBar.swift
//  KisahKata
//
//  Created by Dimas Putro on 04/08/21.
//

import UIKit

class CustomStoryProgressBar: UIProgressView {

    override func layoutSubviews() {
        super.layoutSubviews()

        let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 4.0)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskLayerPath.cgPath
//        CAShapeLayer().shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
//        CAShapeLayer().shadowOffset = CGSize(width: 0, height: 3)
//        CAShapeLayer().shadowOpacity = 1.0
//        CAShapeLayer().shadowRadius = 10.0
//        CAShapeLayer().masksToBounds = false
        layer.mask = maskLayer
    }
}
