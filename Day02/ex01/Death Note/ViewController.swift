//
//  ViewController.swift
//  Death Note
//
//  Created by VirtualMac on 07/01/2022.
//  Copyright © 2022 VirtualMac. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    let myCells = DeathData.myCells
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        
        cell.nameLabel?.text = self.myCells[indexPath.row].getName()
        cell.deathDateLabel?.text = self.myCells[indexPath.row].getDeathDate()
        cell.descriptionLabel?.text = self.myCells[indexPath.row].getDescription()
        return cell
    }
    
    @IBAction func cancelAction(_ segue: UIStoryboardSegue) {}

}

