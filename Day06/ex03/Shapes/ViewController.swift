//
//  ViewController.swift
//  Shapes
//
//  Created by Valeria Karon on 2/8/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    var shapeViews:[ShapeView] = [ShapeView]()
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collider: UICollisionBehavior!
    var bouncingBehavior  : UIDynamicItemBehavior!
    
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue.main
    
    var currentShapeView: ShapeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initAnimator()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if motionManager.isAccelerometerAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: gravityUpdated as! CMDeviceMotionHandler)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func gravityUpdated(motion: CMDeviceMotion!, error: NSError!) {
        if (error != nil) {
            NSLog("\(String(describing: error))")
        }
        let grav : CMAcceleration = motion.gravity;
        
        let x = CGFloat(grav.x)
        let y = CGFloat(grav.y)
        let v = CGVector(dx: x,dy: y)
        gravity.gravityDirection = v
    }
    
    private func initAnimator() {
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        animator.addBehavior(gravity)
        collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collider)
        bouncingBehavior = UIDynamicItemBehavior()
        bouncingBehavior.elasticity = 0.5
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

    private func checkShape(point:CGPoint)->ShapeView? {
        let selectedShapeViews = shapeViews
        for v in selectedShapeViews {
            if v.frame.contains(point) {
                return v
            }
        }
        return nil
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        currentShapeView = checkShape(point: sender.location(in: self.view))
        if currentShapeView == nil {
            currentShapeView = addShape(point: sender.location(in: self.view))
        }
        addAnimatorAndBehaviors(item: currentShapeView!)
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        let tapPoint = sender.location(in: self.view)
        switch  sender.state {
        case .began:
            guard let v = checkShape(point: tapPoint) else { return }
            currentShapeView = v
            removeAnimatorAndBehaviors(item: currentShapeView!)
        case .changed:
            if currentShapeView != nil {
                currentShapeView!.center = tapPoint
            }
        default:
            if currentShapeView != nil {
                addAnimatorAndBehaviors(item: currentShapeView!)
            }
        }
    }
    
    @IBAction func pinchRecognizer(_ sender: UIPinchGestureRecognizer) {
        guard currentShapeView != nil else { return }
        switch  sender.state {
        case .began:
            removeAnimatorAndBehaviors(item: currentShapeView!)
        case .changed:
            currentShapeView!.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            currentShapeView?.bounds = currentShapeView!.frame
            if currentShapeView!.shape.type == .ellipse {
                let radius = currentShapeView!.frame.width / 2.0
                currentShapeView?.shape.radius = radius
                currentShapeView?.layer.cornerRadius = radius
            }
        default:
            addAnimatorAndBehaviors(item: currentShapeView!)
        }
        sender.scale = 1
    }
    
    @IBAction func rotationRecognizer(_ sender: UIRotationGestureRecognizer) {
        guard currentShapeView != nil, currentShapeView!.shape.type == .rectangle else { return }
        switch sender.state {
        case .began:
            removeAnimatorAndBehaviors(item: currentShapeView!)
        case .changed:
            currentShapeView!.transform = currentShapeView!.transform.rotated(by: sender.rotation)
            animator.updateItem(usingCurrentState: currentShapeView!)
        default:
            addAnimatorAndBehaviors(item: currentShapeView!)
        }
        sender.rotation = 0
    }
}
