//
//  ImageBoard.swift
//  Collection view
//
//  Created by Valeria Karon on 1/10/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit


class ImageBoard: UICollectionViewController {

    let im :[String] = [
        "",
"https://images-assets.nasa.gov/image/PIA09178/PIA09178~orig1.jpg",
"https://images-assets.nasa.gov/image/PIA18033/PIA18033~orig.jpg",
"https://images-assets.nasa.gov/image/behemoth-black-hole-found-in-an-unlikely-place_26209716511_o/behemoth-black-hole-found-in-an-unlikely-place_26209716511_o~orig1.jpg",
"https://images-assets.nasa.gov/image/as16-113-18339/as16-113-18339~orig.jpg"]
    
    var errors = [String]()
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return im.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ImageCell {
            let index = indexPath.row
            let fileName = im[index]
            countryCell.setNameCell(with: fileName) {f in
                self.count += 1
                if let file = f { self.errors.append(file) }
                if self.count == self.im.count {
                    self.showAlert(errors: self.errors)
                }
            }
            cell = countryCell
        }
        return cell
    }

    private func showAlert(errors:[String]) {
        if errors.isEmpty { return }
        let message = "Cannot access to \"\(errors[0])\""
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) {_ in
            if errors.count > 1 {
                self.showAlert(errors: Array(errors[1..<errors.count]))
            }
        }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       /*
        if segue.identifier == "showImage" {
            //guard let indexPath = collectionView.indexPathForSelectedRow else {
             //   return }
            guard let indexPath = collectionView.indexPathsForSelectedItems else { return }
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath[0]) as? ImageCell else {return}
            
            let imageShowVC = segue.destination as! ImageShow
            imageShowVC.detailImage = cell.image
        }
        */
    
   
        if (segue.identifier == "imageShow") {
            let cell = sender as! ImageCell//UICollectionViewCell //Change UICollectionViewCell with CustomCell name if you are using CustomCell
            //let indexPath = self.collectionView?.indexPath(for: cell)
            guard let currentImage = cell.image.image else { return }
            let destVC = segue.destination as! ImageShow
            destVC.selectedImage = currentImage
        }
    }
}
