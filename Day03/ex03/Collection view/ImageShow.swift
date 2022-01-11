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
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
