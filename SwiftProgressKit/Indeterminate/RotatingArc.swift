//
//  RotatingArc.swift
//  SwiftProgressKit
//
//  Created by Mazy on 2018/7/22.
//  Copyright © 2018年 mazy. All rights reserved.
//

import UIKit

private let duration = 0.25

@IBDesignable
class RotatingArc: IndeterminateAnimation {

    var backgroundCircle = CAShapeLayer()
    var arcLayer = CAShapeLayer()
    
    @IBInspectable open var strokeWidth: CGFloat = 5 {
        didSet {
            notifyViewRedesigned()
        }
    }
    
    @IBInspectable open var arcLength: Int = 35 {
        didSet {
            notifyViewRedesigned()
        }
    }
    
    @IBInspectable open var clockWise: Bool = true {
        didSet {
            notifyViewRedesigned()
        }
    }
    
    var radius: CGFloat {
        return (self.frame.width / 2) * CGFloat(0.5)
    }
    
    var rotationAnimation: CABasicAnimation = {
        var tempRotation = CABasicAnimation(keyPath: "transform.rotation")
        tempRotation.repeatCount = Float.infinity
        tempRotation.fromValue = 0
        tempRotation.toValue = 1
        tempRotation.isCumulative = true
        tempRotation.duration = duration
        return tempRotation
    }()
    
    override func notifyViewRedesigned() {
        super.notifyViewRedesigned()
        
        arcLayer.strokeColor = foreground.cgColor
        backgroundCircle.strokeColor = foreground.withAlphaComponent(0.4).cgColor
        
        backgroundCircle.lineWidth = self.strokeWidth
        arcLayer.lineWidth = strokeWidth
        rotationAnimation.toValue = clockWise ? -1 : 1
        
        let arcPath = UIBezierPath()
        let endAngle: CGFloat = CGFloat(-360) * CGFloat(arcLength) / 100
        
        arcPath.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)
        
        arcLayer.path = arcPath.cgPath
    }
    
    override func configureLayers() {
        super.configureLayers()
        let rect = self.bounds
        
        // Add background Circle
        do {
            backgroundCircle.frame = rect
            backgroundCircle.lineWidth = strokeWidth
            
            backgroundCircle.strokeColor = foreground.withAlphaComponent(0.5).cgColor
            backgroundCircle.fillColor = UIColor.clear.cgColor
            let backgroundPath = UIBezierPath()
            
            backgroundPath.addArc(withCenter: CGPoint(x: rect.midX, y: rect.midY), radius: radius, startAngle: 0, endAngle: 360, clockwise: true)
            backgroundCircle.path = backgroundPath.cgPath
            self.layer.addSublayer(backgroundCircle)
        }
        
        // Arc Layer
        do {
            arcLayer.fillColor = UIColor.clear.cgColor
            arcLayer.lineWidth = strokeWidth
            
            arcLayer.frame = rect
            arcLayer.strokeColor = foreground.cgColor
            self.layer.addSublayer(arcLayer)
        }
    }
    
    override func startAnimation() {
        arcLayer.add(rotationAnimation, forKey: "")
    }
    
    override func stopAnimation() {
        arcLayer.removeAllAnimations()
    }
    
}
