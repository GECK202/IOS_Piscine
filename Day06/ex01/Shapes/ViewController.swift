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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAnimator()
    }
    
    private func initAnimator() {
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        animator.addBehavior(gravity)
        collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collider)
        bouncingBehavior = UIDynamicItemBehavior()
        bouncingBehavior.elasticity = 0.05
        animator.addBehavior(bouncingBehavior)
    }
    
    private func addShape(point: CGPoint)->ShapeView {
        let shapeView = ShapeView(point: point)
        shapeView.translatesAutoresizingMaskIntoConstraints = true
        self.shapeViews.append(shapeView)
        self.view.addSubview(shapeView)
        return shapeView
    }
    
    private func addAnimatorAndBehaviors(item: ShapeView) {
        gravity.addItem(item)
        collider.addItem(item)
        bouncingBehavior.addItem(item)
    }
    
    private func removeAnimatorAndBehaviors(item: ShapeView) {
        gravity.removeItem(item)
        collider.removeItem(item)
        bouncingBehavior.removeItem(item)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        addAnimatorAndBehaviors(item: addShape(point: sender.location(in: self.view)))
    }
}

