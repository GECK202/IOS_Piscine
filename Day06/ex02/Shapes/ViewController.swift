//
//  ViewController.swift
//  Shapes
//
//  Created by Valeria Karon on 2/8/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var shapeViews:[ShapeView] = [ShapeView]()
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collider: UICollisionBehavior!
    var bouncingBehavior  : UIDynamicItemBehavior!
    
    private func addShape(point: CGPoint) {
        let shapeView = ShapeView(point: point)
        self.shapeViews.append(shapeView)
        self.view.addSubview(shapeView)
    }
    
    private func addAnimatorAndBehaviors() {
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        gravity = UIGravityBehavior(items: shapeViews)
        animator.addBehavior(gravity)
        
        collider = UICollisionBehavior(items: shapeViews)
        collider.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collider)
        
        bouncingBehavior = UIDynamicItemBehavior(items: shapeViews)
        bouncingBehavior.elasticity = 0.05
        animator.addBehavior(bouncingBehavior)
    }
    
    private func checkShape(point:CGPoint)->ShapeView? {
        for v in shapeViews {
            //let halfSize = v.shape.size / 2
            //if (v.shape.type == .rectangle) {
            if v.frame.contains(point) {
                return v
            }
            //} else {
                
            //}
        }
        return nil
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
        
        addShape(point: point)
        addAnimatorAndBehaviors()
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let tr = sender.location(in: self.view)
        print("x=", tr.x, "y=", tr.y)
        guard let v = checkShape(point: tr) else { return }
        v.center = tr
    }
}

