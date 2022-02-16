//
//  Shape.swift
//  Shapes
//
//  Created by Valeria Karon on 2/8/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ShapeView: UIView {
    
    //let view:UIView
    var shape: ShapeModel
    
    init(point: CGPoint) {
        shape = ShapeModel()
        super.init(frame: CGRect(to: point, shape.size))
        backgroundColor = shape.color
        layer.cornerRadius = shape.radius
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return self.shape.type
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

