//
//  ViewController.swift
//  TableView
//
//  Created by VirtualMac on 02/01/2022.
//  Copyright © 2022 VirtualMac. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let myCells = CellData.myCells
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        
        cell.nameLabel.text = myCells[indexPath.row].getName()
        cell.deathDateLabel.text = myCells[indexPath.row].getDeathDate()
        cell.descriptionLabel.text = myCells[indexPath.row].getDescription()
        return cell
    }


}

