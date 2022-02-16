//
//  DetailViewController.swift
//  Rush00
//
//  Created by Valeria Karon on 2/13/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    let user = APIDataManager.testUser
    var events: [EventsModel]?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var cursusControl: UISegmentedControl!
    
    @IBAction func cursusControlChange(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        currentLevelLabel.text = "\(user.cursusUsers[index].level)"
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func updateInterface() {
        nameLabel.text = "Name: \(user.firstName)"
        surNameLabel.text = "Surname: \(user.lastName)"
        loginLabel.text = "Login: \(user.login)"
        cursusControl.removeAllSegments()
        var index = 0
        for cursus in user.cursusUsers {
            cursusControl.insertSegment(withTitle: cursus.cursus.name, at: index, animated: true)
            index += 1
        }
        cursusControl.selectedSegmentIndex = 0
        currentLevelLabel.text = "\(user.cursusUsers[0].level)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        updateInterface()
        
        events = APIDataManager.addTestEvents()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailEvent" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let event = events![indexPath.row]
            let devc = segue.destination as! DetailEventViewController
            devc.event = event
        }
        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events!.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = events![indexPath.row].name
        cell.detailTextLabel?.text = events![indexPath.row].description

        return cell
    }

}
