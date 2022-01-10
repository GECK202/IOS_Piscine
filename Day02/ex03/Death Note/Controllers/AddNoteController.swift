//
//  AddNoteController.swift
//  Death Note
//
//  Created by VirtualMac on 09/01/2022.
//  Copyright © 2022 VirtualMac. All rights reserved.
//

import UIKit

class AddNoteController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var deathDatePicker: UIDatePicker!
    
    @IBOutlet weak var descriptionTextField: UITextView!
        
    func addNote()->Note? {
        guard let name = nameTextField.text else { return nil }
        guard name != "" else { return nil }
        let note = Note(name: name, date: deathDatePicker.date, description: descriptionTextField.text)
        return note

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }

}

