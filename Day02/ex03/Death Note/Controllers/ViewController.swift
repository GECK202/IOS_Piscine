//
//  ViewController.swift
//  Death Note
//
//  Created by VirtualMac on 07/01/2022.
//  Copyright © 2022 VirtualMac. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DeathData.myCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        
        cell.nameLabel?.text = DeathData.myCells[indexPath.row].getName()
        cell.deathDateLabel?.text = DeathData.myCells[indexPath.row].getDeathDate()
        cell.descriptionLabel?.text = DeathData.myCells[indexPath.row].getDescription()
        return cell
    }
    
    @IBAction func addNoteAction(_ segue: UIStoryboardSegue) {
        guard let newPlaceVC = segue.source as? AddNoteController else { return }
        if let note = newPlaceVC.addNote() {
            DeathData.myCells.append(note)
            print(note)
            tableView.reloadData()
        } else { print("name is empty!") }
    }

}

