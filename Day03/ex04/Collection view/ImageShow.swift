//
//  ImageShow.swift
//  Collection view
//
//  Created by Valeria Karon on 1/11/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ImageShow: UIViewController {

    var selectedImage: UIImage?
    
    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = selectedImage
    }
    
    @IBAction func PinchGestureRecognizer(_ sender: UIPinchGestureRecognizer) {
        detailImage.transform = CGAffineTransform(scaleX: sender.scale, y: sender.scale)
    }
     
    
    @IBAction func PanGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        detailImage.center = CGPoint(x: detailImage.center.x + translation.x, y: detailImage.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
}
