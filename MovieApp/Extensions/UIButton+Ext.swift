//
//  UIButton+Ext.swift
//  MovieApp
//
//  Created by Erdoğan Turpcu on 22.08.2022.
//

import UIKit

extension UIButton {
    func setDashedBorder() {
        let color = UIColor.green.cgColor

        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let shapeRect = CGRect(x: 0, y: 0, width: frame.size.width, height: 60)

        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: (frame.size.width)/2, y: 60/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [10,5]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 10).cgPath
        layer.addSublayer(shapeLayer)
    }
}
