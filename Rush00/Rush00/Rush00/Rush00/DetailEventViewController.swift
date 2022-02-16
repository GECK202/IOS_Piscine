//
//  DetailEventViewController.swift
//  Rush00
//
//  Created by Valeria Karon on 2/13/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class DetailEventViewController: UIViewController {

    var event:[EventsModel]?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberOfGuests: UILabel!
    @IBOutlet weak var maxNumberOfGuests: UILabel!
    @IBOutlet weak var localisation: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var startingTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var campusLabel: UILabel!
    @IBOutlet weak var cursusLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
