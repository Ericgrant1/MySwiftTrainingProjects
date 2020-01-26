//
//  ViewController.swift
//  MyBasicCalculator
//
//  Created by Eric on 04.01.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit

enum Calculation: String {
    case addition = "+"
    case substraction = "-"
    case division = "*"
    case multiplication = "/"
    case empty = "empty"
}

class ViewController: UIViewController {

    @IBOutlet weak var calculationLabel: UILabel!
    
    var operatingNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentCalculation: Calculation = .empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculationLabel.text = "0"
    }

    @IBAction func buttonNumbered(_ sender: RoundButton) {
        if operatingNumber.count <= 8 {
            operatingNumber += "\(sender.tag)"
            calculationLabel.text = operatingNumber
        }
    }
    
    @IBAction func acButton(_ sender: RoundButton) {
        operatingNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentCalculation = .empty
        calculationLabel.text = "0"
    }
    
    @IBAction func dotButton(_ sender: RoundButton) {
        if operatingNumber.count <= 7 {
            operatingNumber += "."
            calculationLabel.text = operatingNumber
        }
    }
    
    @IBAction func divisionButton(_ sender: RoundButton) {
        calculation(operation: .division)
    }
    
    @IBAction func multiplicationButton(_ sender: RoundButton) {
        calculation(operation: .multiplication)
    }
    
    @IBAction func substractionButton(_ sender: RoundButton) {
        calculation(operation: .substraction)
    }
    
    @IBAction func additionButton(_ sender: RoundButton) {
        calculation(operation: .addition)
    }
    
    @IBAction func equalButton(_ sender: RoundButton) {
        calculation(operation: currentCalculation)
    }
    
    func calculation(operation: Calculation) {
        if currentCalculation != .empty {
            if operatingNumber != "" {
                rightValue = operatingNumber
                operatingNumber = ""
                
                if currentCalculation == .addition {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                } else if currentCalculation == .substraction {
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                } else if currentCalculation == .multiplication {
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                } else if currentCalculation == .division {
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                leftValue = result
                if (Double(result)!.truncatingRemainder(dividingBy: 1) == 0) {
                    result = "\(Int(Double(result)!))"
                }
                calculationLabel.text = result
            }
            currentCalculation = operation
            
        } else {
            leftValue = operatingNumber
            operatingNumber = ""
            currentCalculation = operation
        }
    }
    
}

