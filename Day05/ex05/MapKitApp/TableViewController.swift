//
//  TableViewController.swift
//  MapKitApp
//
//  Created by Valeria Karon on 1/26/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var conclusion:((String)->())!
    
    let location:[String] = ["42","Sent Ouen", "Grenoble", "Reims", "Moldavie", "Circuit"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return location.count
    }
    
    //*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = location[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if conclusion != nil {
            conclusion(location[indexPath.row])
        }
    }
    
    
}

