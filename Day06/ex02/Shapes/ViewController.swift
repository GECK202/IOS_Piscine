//
//  ViewController.swift
//  Shapes
//
//  Created by Valeria Karon on 2/8/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//
/*
import UIKit

class ViewController: UIViewController {

    var shapeViews:[ShapeView] = [ShapeView]()
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collider: UICollisionBehavior!
    var bouncingBehavior  : UIDynamicItemBehavior!
    
    var currentShapeView: ShapeView?
    
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
    

    
    private func checkShape(point:CGPoint)->ShapeView? {
        let selectedShapeViews = shapeViews/*.filter{(shape) in
            switch shape.shape.type {
            case .ellipse:
                return true
            case .rectangle:
                return true
            default:
                return false
            }
        }*/
        for v in selectedShapeViews {
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
        addAnimatorAndBehaviors(item: addShape(point: sender.location(in: self.view)))
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
                //currentShapeView = nil
            }
        }
    }
    
    @IBAction func pinchRecognizer(_ sender: UIPinchGestureRecognizer) {
        print("pinch")
        if currentShapeView != nil {
            currentShapeView!.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
            
        }
        if sender.state == .ended {
            currentShapeView!.bounds = currentShapeView!.frame
            currentShapeView!.shape.size = currentShapeView!.bounds.width
        }
        /*
        //var lastdist: CGFloat = 1
        let tapPoint = sender.location(in: self.view)
        switch sender.state {
        case .began:
            guard let v = checkShape(point: tapPoint) else { return }
            currentShapeView = v
            gravity.removeItem(currentShapeView!)
            self.view.bringSubviewToFront(currentShapeView!)
            //lastdist = sender.scale
        case .changed:
            if currentShapeView != nil {
                collider.removeItem(currentShapeView!)
                //let newSize = (currentShapeView!.shape.size) * (sender.scale / lastdist)
                //currentShapeView!.bounds.size = CGSize(width: newSize, height: newSize)
                currentShapeView!.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
                
                collider.addItem(currentShapeView!)
            }
        default:
            if currentShapeView != nil {
                gravity.addItem(currentShapeView!)
                currentShapeView = nil
            }
        }*/
    }
    
    @IBAction func rotationRecognizer(_ sender: UIRotationGestureRecognizer) {
    }
    
}
*/


import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var forms: [ShapeView] = []
    var select: ShapeView? = nil
    
    let gravity = UIGravityBehavior()
    let collision = UICollisionBehavior()
    let behaviour = UIDynamicItemBehavior()
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue.main

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = true
        let gPan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.panGesture(_:)))
        view.addGestureRecognizer(gPan)
        let gTap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapGesture(_:)))
        view.addGestureRecognizer(gTap)
        let gPin = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.pinGesture(_:)))
        view.addGestureRecognizer(gPin)
        let gRot = UIRotationGestureRecognizer(target: self, action: #selector(ViewController.rotGesture(_:)))
        view.addGestureRecognizer(gRot)
        
        // Create the animator
        animator = UIDynamicAnimator(referenceView: view)
        gravity.gravityDirection = CGVector(dx:0, dy: 0.8)
        animator.addBehavior(gravity)
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        behaviour.elasticity = 0.5
        animator.addBehavior(behaviour)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    @objc func tapGesture(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            let newForm = ShapeView(point: sender.location(in: self.view))
            newForm.translatesAutoresizingMaskIntoConstraints = true
            newForm.center = sender.location(in: self.view)
            self.view.addSubview(newForm)
            //  upgrade size to 100
            UIView.animate(withDuration: 0.3) {
                newForm.bounds.size = CGSize(width: 100, height: 100)
            }
            forms.append(newForm)
            gravity.addItem(newForm)
            collision.addItem(newForm)
            behaviour.addItem(newForm)
        default:
            print("tap.default")
        }
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in forms {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                self.view.bringSubviewToFront(select!)
                gravity.removeItem(select!)
            }
        case .changed:
            if select != nil {
                select!.center = sender.location(in: self.view)
                animator.updateItem(usingCurrentState: select!)
            }
        default:
            if select != nil {
                gravity.addItem(select!)
                select = nil
            }
        }
    }
    
    @objc func pinGesture(_ sender: UIPinchGestureRecognizer) {
        var lastdist: CGFloat = 1
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in forms {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                gravity.removeItem(select!)
                self.view.bringSubviewToFront(select!)
                lastdist = sender.scale
            }
        case .changed:
            if select != nil {
                collision.removeItem(select!)
                select!.bounds.size = CGSize(width: 100*(sender.scale/lastdist), height: 100*(sender.scale/lastdist))
                animator.updateItem(usingCurrentState: select!)
                collision.addItem(select!)
            }
        default:
            if select != nil {
                print("pan.default \(select!.center)")
                gravity.addItem(select!)
                select = nil
            }
        }
    }
    
    @objc func rotGesture(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in forms {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                gravity.removeItem(select!)
                self.view.bringSubviewToFront(select!)
            }
        case .changed:
            if select != nil {
                select!.transform = select!.transform.rotated(by: sender.rotation)
                animator.updateItem(usingCurrentState: select!)
                sender.rotation = 0
            }
        default:
            if select != nil {
                gravity.addItem(select!)
                select = nil
            }
        }
    }


}
