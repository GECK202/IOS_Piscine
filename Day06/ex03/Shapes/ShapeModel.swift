//
//  ShapeModel.swift
//  Shapes
//
//  Created by Valeria Karon on 2/8/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

struct ShapeModel {
    
    var size: CGFloat
    let color: UIColor
    let type: UIDynamicItemCollisionBoundsType
    var radius: CGFloat
    let isDeleted = false
    
    init() {
        size = .random(from: 100, to: 100)
        color = .random()
        let r = CGFloat.random()
        type = (r > 0.5) ? .ellipse : .rectangle
        radius = CGFloat(Int(r + 0.5)) * size / 2
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
