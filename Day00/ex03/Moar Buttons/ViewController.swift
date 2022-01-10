//
//  ViewController.swift
//  Moar Buttons
//
//  Created by Valeria Karon on 1/10/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Result: UILabel!
    
    var calculator: Calculator = Calculator()

    @IBAction func acButton(_ sender: UIButton) {
        Result.text = calculator.allClear()
    }
    @IBAction func resButton(_ sender: UIButton) {
        Result.text = calculator.calculate()
    }
    @IBAction func negButton(_ sender: UIButton) {
        Result.text = calculator.setNeg()
    }
    
    @IBAction func keyNumber(_ sender: UIButton) {
        var num: String
        num = sender.titleLabel!.text!
        Result.text = calculator.addDigit(num)
    }
    
    @IBAction func keyFunc(_ sender: UIButton) {
        var op: String
        op = sender.titleLabel!.text!
        Result.text = calculator.setOpName(op)
    }
}

