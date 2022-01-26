//
//  ViewController.swift
//  TweetsViewer
//
//  Created by Valeria Karon on 1/23/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let api = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ButtonClick(_ sender: UIButton) {
        api.queryRequest(find: "42")
    }
    
}

