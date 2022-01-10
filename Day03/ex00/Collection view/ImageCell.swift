//
//  ImageCell.swift
//  Collection view
//
//  Created by Valeria Karon on 1/10/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    

    @IBOutlet weak var image: UIImageView!
    
    func setNameCell(with name:String) {
        let url = URL(string: name)!
        if let data = try? Data(contentsOf: url) {
            // Create Image and Update Image View
            image.image = UIImage(data: data)
        }
    }
}
