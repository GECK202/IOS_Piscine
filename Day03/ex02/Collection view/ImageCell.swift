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
    
    func setNameCell(with name:String,  action: @escaping (String?)->()) {
        showSpinner()
        guard let url = URL(string: name) else {
            print("file not URL!: \"\(name)\"\n")
            hideSpinner()
            action(name)
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                    self.hideSpinner()
                    action(nil)
                }
            } else {
                print("file not found!: \"\(name)\"\n")
                DispatchQueue.main.async {
                    action(name)
                    self.hideSpinner()
                }
            }
        }
    }
    
    
    
    private func showSpinner() {
        spinner.startAnimating()
        image.isHidden = true
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    private func hideSpinner() {
        spinner.stopAnimating()
        spinner.isHidden = true
        image.isHidden = false
        //UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
