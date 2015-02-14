//
//  ViewController.swift
//  Stanford1
//
//  Created by Paul Brewczynski on 2/6/15.
//  Copyright (c) 2015 Paul Brewczynski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfEnteringNumber = false;
    
    @IBAction func digitTouchUpInside(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfEnteringNumber {
            self.display.text = self.display.text! + digit
        } else {
            self.display.text = digit
            self.userIsInTheMiddleOfEnteringNumber = true
        }
    }
    
    var stack : Array<Double> = Array<Double>();
    
    @IBAction func operationTouchUpInside(sender: UIButton) {
        let operationSign = sender.currentTitle!;
        
        if userIsInTheMiddleOfEnteringNumber {
            self.finishEnteringNumber()
        }
        
        switch operationSign {
        case "×": self.performCalculatorOperation() { $1 * $0 }
        case "÷": self.performCalculatorOperation() { $1 / $0 }
        case "+": self.performCalculatorOperation() { $1 + $0 }
        case "−": self.performCalculatorOperation() { $1 - $0 }
        case "√": self.performCalculatorOperation() { sqrt($0)}
        default: break
        }
        
        /*
        if(self.stack.count >= 2) {
            
            var o1 = self.stack.removeLast()
            var o2 = self.stack.removeLast()
            
            var result :Double  = 0;
            switch operationSign {
            case "×": result = self.performOperation(o1, o2:  o2, operation:  {(a1: Double, a2: Double) -> Double in return o1 * o2})
            case "÷": result = self.performOperation(o1, o2: o2, operation:{ (a1, a2) -> Double in return o2/o1 })
            case "+": result = self.performOperation(o1, o2: o2, operation: { (a1, a2) in return o1+o2})
            case "−": result = self.performOperation(o1, o2: o2, operation: { $0-$1})
                
            case "√": result = self.performOperation(o1 , operation: { sqrt($0) }) // error bug - extract it and report it (you will feel better)
                
            default: break
            }
            
            
            self.displayValue = result
            self.stack.append(result)
            self.userIsInTheMiddleOfEnteringNumber = false
        }
*/
    }
    
    
    
    func performCalculatorOperation(operation: (Double, Double) -> Double) { // Two arguments operation
        if(self.stack.count >= 2) {
            self.displayValue = operation(self.stack.removeLast(), self.stack.removeLast())
            self.finishEnteringNumber() // it will push result on the stack
        }
        print("Stack afer operation \(self.stack)")
    }
    
    
    func performCalculatorOperation(operation: (Double) -> Double) {
        if(self.stack.count >= 1) {
            self.displayValue = operation(self.stack.removeLast())
            self.finishEnteringNumber()
        }
        print("Stack afer operation \(self.stack)")
    }
    
    
    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(self.display.text!)!.doubleValue
        }
        set {
            self.display.text = "\(newValue)"
        }
    }
    
    
    func performOperation(o1: Double, o2: Double, operation: (Double, Double) -> Double) -> Double {
        return operation(o1, o2)
    }
    
    func performOperation(o1: Double,operation:  (Double) -> Double) -> Double {
        return operation(o1)
    }
    
    @IBAction func returnTouchUpInside(sender: UIButton) {
        self.finishEnteringNumber()
    }
    
    func finishEnteringNumber() {
        self.userIsInTheMiddleOfEnteringNumber = false
        self.stack.append(self.displayValue)
        println("Finished entering number - stack \(stack)")
    }
}

