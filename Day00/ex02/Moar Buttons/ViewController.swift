//
//  ViewController.swift
//  Moar Buttons
//
//  Created by Valeria Karon on 1/10/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func keyButton(_ sender: UIButton) {
        let keyName:String = sender.titleLabel!.text!
        display.text = keyName
        print("Press key \(keyName)")
    }
    
}

