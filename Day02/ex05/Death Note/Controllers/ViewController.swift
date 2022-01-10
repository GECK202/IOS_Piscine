//
//  ViewController.swift
//  Death Note
//
//  Created by VirtualMac on 07/01/2022.
//  Copyright © 2022 VirtualMac. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var currentIndex = 0
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DeathData.myCells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 2
        
        cell.nameLabel?.text = DeathData.myCells[indexPath.row].getName()
        cell.deathDateLabel?.text = DeathData.myCells[indexPath.row].getDeathDateString()
        cell.descriptionLabel?.text = DeathData.myCells[indexPath.row].getDescription()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNote" {
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return }
            currentIndex = indexPath.row
            let note = DeathData.myCells[currentIndex]
            let newNoteVC = segue.destination as! AddNoteController
            newNoteVC.currentNote = note
        }
    }
    
    @IBAction func addNoteAction(_ segue: UIStoryboardSegue) {
        guard let newNoteVC = segue.source as? AddNoteController else { return }
        if let note = newNoteVC.addNote() {
            if let _ = newNoteVC.currentNote {
                DeathData.myCells[currentIndex] = note
                print("Note with index \(currentIndex) was change to \(note)")
            } else {
                DeathData.myCells.append(note)
                print(note)
            }
            tableView.reloadData()
        } else { print("name is empty!") }
    }

}

