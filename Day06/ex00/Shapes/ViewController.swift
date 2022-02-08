//
//  ViewController.swift
//  Shapes
//
//  Created by Valeria Karon on 2/8/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private func addShape(point: CGPoint) {
        let size:CGFloat = .random(from: 100, to: 100)
        let halfSize:CGFloat = size / 2
        let myView = UIView(frame: CGRect(to: point, size))
        myView.backgroundColor = .random()
        myView.layer.cornerRadius = CGFloat(Int(CGFloat.random() + 0.5)) * halfSize
        myView.clipsToBounds = true
        self.view.addSubview(myView)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        addShape(point: sender.location(in: self.view))
    }
}

extension CGRect {
    init(to point: CGPoint, _ size: CGFloat) {
        let halfSize:CGFloat = size / 2
        let x = point.x - halfSize
        let y = point.y - halfSize
        let size = size
        self.init(x: x, y: y, width: size, height: size)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    static func random(from: Int, to: Int) -> CGFloat {
        let delta = to - from
        guard delta >= 0, from >= 0 else { return 100 }
        return CGFloat.random() * CGFloat(delta) + CGFloat(from)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

