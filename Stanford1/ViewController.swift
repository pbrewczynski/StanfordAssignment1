//
//  ViewController.swift
//  Stanford1
//
//  Created by Paul Brewczynski on 2/6/15.
//  Copyright (c) 2015 Paul Brewczynski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Stored properties
    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfEnteringNumber = false;
    var stack : Array<Double> = Array<Double>();
    
    // MARK: Computed properties
    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(self.display.text!)!.doubleValue
        }
        set {
            self.display.text = "\(newValue)"
        }
    }
    
    
    // MARK: IBActions
    @IBAction func digitTouchUpInside(sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfEnteringNumber {
            self.display.text = self.display.text! + digit
        } else {
            self.display.text = digit
            self.userIsInTheMiddleOfEnteringNumber = true
        }
    }
    
    
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
    }
    
    @IBAction func returnTouchUpInside(sender: UIButton) {
        self.finishEnteringNumber()
    }
    
  
    
    // MARK: Model
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
    
    func finishEnteringNumber() {
        self.userIsInTheMiddleOfEnteringNumber = false
        self.stack.append(self.displayValue)
        println("Finished entering number - stack \(stack)")
    }
}