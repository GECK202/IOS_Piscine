//
//  ViewController.swift
//  Supersize me
//
//  Created by Valeria Karon on 1/10/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var clicks = 0
    
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ClickButton(_ sender: UIButton) {
        clicks += 1
        helloLabel.text = "Hello World ! \(clicks)"
    }
    
    
}

