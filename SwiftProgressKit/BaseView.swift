//
//  BaseView.swift
//  SwiftProgressKit
//
//  Created by Mazy on 2018/7/22.
//  Copyright © 2018年 mazy. All rights reserved.
//

import UIKit

@IBDesignable
class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayers()
    }
    
    /// Configure the Layers
    private func configureLayers() {
        notifyViewRedesigned()
    }

    @IBInspectable open var background: UIColor = UIColor(red: 88.3 / 256, green: 104.4 / 256, blue: 118.5 / 256, alpha: 1.0) {
        didSet {
            self.notifyViewRedesigned()
        }
    }
    
    @IBInspectable open var foreground: UIColor = UIColor(red: 66.3 / 256, green: 173.7 / 256, blue: 106.4 / 256, alpha: 1.0) {
        didSet {
            self.notifyViewRedesigned()
        }
    }
    
    @IBInspectable open var cornerRadius: CGFloat = 5.0 {
        didSet {
            self.notifyViewRedesigned()
        }
    }
    
    /// Call when any IBInspectable variable is changed
    func notifyViewRedesigned() {
        self.layer.backgroundColor = background.cgColor
        self.layer.cornerRadius = cornerRadius
    }
}
