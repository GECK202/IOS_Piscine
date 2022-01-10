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
"https://images-assets.nasa.gov/image/PIA09178/PIA09178~orig.jpg",
"https://images-assets.nasa.gov/image/PIA18033/PIA18033~orig.jpg",
"https://images-assets.nasa.gov/image/behemoth-black-hole-found-in-an-unlikely-place_26209716511_o/behemoth-black-hole-found-in-an-unlikely-place_26209716511_o~orig.jpg",
"https://images-assets.nasa.gov/image/as16-113-18339/as16-113-18339~orig.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return im.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let countryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? ImageCell {
            countryCell.setNameCell(with: im[indexPath.row])
            cell = countryCell
        }
    
        // Configure the cell
    
        return cell
    }


}
