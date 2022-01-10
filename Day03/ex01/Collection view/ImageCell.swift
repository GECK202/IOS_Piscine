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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func setNameCell(with name:String) {
        let url = URL(string: name)!
        showSpinner()
        DispatchQueue.global().async {
            // Fetch Image Data
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    // Create Image and Update Image View
                    self.image.image = UIImage(data: data)
                    self.hideSpinner()
                }
            }
        }
    }
    
    private func showSpinner() {
        spinner.startAnimating()
        image.isHidden = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    private func hideSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
        image.isHidden = false
    }
}
