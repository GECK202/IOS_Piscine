//
//  Calculator.swift
//  Moar Buttons
//
//  Created by Valeria Karon on 1/10/22.
//  Copyright © 2022 Valeria Karon. All rights reserved.
//

import Foundation

class Calculator {
    
    private var operand1:Operand = Operand()
    private var operand2:Operand = Operand()
    private var curOperand:Operand
    private var operation: String?
    private var error:String?
    
    init() {
        curOperand = operand1
    }
    
    func calculate()->String {
        if error != nil {
            return error!
        }
        guard let opName = operation else {return String(operand1.value)}
        if opName == "/" && 0 == operand2.value {
            error = "Error! Divide by zero!"
            return error!
        }
        if operand1.calculateWithOverflow(operand2.value, opName) {
            error = "Error! Operation overflow!"
            return error!
        }
        curOperand = operand1
        return String(operand1.value)
    }
    
    func addDigit(_ value: String)->String {
        if error != nil {
            return error!
        }
        curOperand.addDigit(Int(value)!)
        return String(curOperand.value)
    }
    
    func setNeg()->String {
        if error != nil {
            return error!
        }
        curOperand.value = -1 * curOperand.value
        return String(curOperand.value)
    }
    
    func setOpName(_ value: String)->String {
        if error != nil {
            return error!
        }
        operation = value
        operand2.value = 0
        curOperand = operand2
        return (String(operand1.value) + value)
    }
    
    func allClear()->String {
        operand1.value = 0
        operand2.value = 0
        curOperand = operand1
        operation = nil
        error = nil
        return "0"
    }
        
    final class Operand{
        var value: Int = 0
        static let operation: [String : (Int, Int)->(Int, Bool)] =
            ["+": {$0.addingReportingOverflow($1)},
            "-": {$0.subtractingReportingOverflow($1)},
            "*": {$0.multipliedReportingOverflow(by: $1)},
            "/": {($0 / $1, false)}]
        
        func addDigit(_ value: Int) {
            var (tmp, error) = self.value.multipliedReportingOverflow(by: 10)
            if !error {
                if self.value >= 0 {
                    (tmp, error) = tmp.addingReportingOverflow(value)
                } else {
                    (tmp, error) = tmp.subtractingReportingOverflow(value)
                }
                if !error {
                    self.value = tmp
                }
            }
        }
        
        func calculateWithOverflow (_ value2: Int, _ opName: String)->Bool {
            var result: Bool
            (self.value, result) = Operand.operation[opName]!(self.value, value2)
            return result
        }
    }
}
