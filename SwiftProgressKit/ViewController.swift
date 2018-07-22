//
//  ViewController.swift
//  SwiftProgressKit
//
//  Created by Mazy on 2018/7/22.
//  Copyright © 2018年 mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let indeterminateAnimations = view.subviews.filter({ $0.isKind(of: IndeterminateAnimation.self) }) as! [IndeterminateAnimation]
        indeterminateAnimations.forEach({ $0.animate = true })
    }


}

