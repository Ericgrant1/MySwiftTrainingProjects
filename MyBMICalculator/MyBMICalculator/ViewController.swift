//
//  ViewController.swift
//  MyBMICalculator
//
//  Created by Eric Grant on 02.02.2020.
//  Copyright © 2020 Eric Grant. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var colorBMIView: UIView!
    @IBOutlet weak var resultBMILabel: UILabel!
    @IBOutlet weak var descriptionBMITextView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.
        colorBMIView.backgroundColor = UIColor.white
        // 1.
        
        // 9.
        let barButtonItem = UIBarButtonItem.init(title: "About App", style: .plain, target: self, action: #selector(showAbout(_:)))
        navigationItem.rightBarButtonItem = barButtonItem
        // 9.
    }
    
    // 10.
    @objc private func showAbout(_ sender: Any) {
        
        performSegue(withIdentifier: "showAbout", sender: nil)
    }
    // 10.

    @IBAction func calculateButtonTappedAction(_ sender: Any) {
        
        // 8. Скрываем клавиатуру
        view.endEditing(true)
        // 8.
        
        // 3. Выполняем проверку
        if heightWeightCheck() == true {
            let height = Double(heightTextField.text!)! / 100
            let weight = Double(weightTextField.text!)!
            
            let bmi = weight / (pow(height, 2))
            
            let desctiptionBMI = getDescriptionBMI(bmi: bmi) // 6.1
            let colorBMI = getColorBMI(bmi: bmi) // 6.2
            
            // 7.
            resultBMILabel.text = String(format: "%.2f", bmi)
            descriptionBMITextView.text = desctiptionBMI
            colorBMIView.backgroundColor = colorBMI
            // 7.
            
        } else {
            let alertController = UIAlertController.init(title: "Attention", message: "All fields must be filled", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
            
        }
        // 3.
    }
    
    // 2. Проверка на заполненность всех полей
    private func heightWeightCheck() -> Bool {
        guard let height = heightTextField.text, height.count > 0 else { return false }
        guard let weight = weightTextField.text, weight.count > 0 else { return false }
        
        return true
    }
    // 2.
    
    // 4.
    private func getDescriptionBMI(bmi: Double) -> String {
        
        var descriptionBMI = ""
        if bmi < 17.5 {
            descriptionBMI = "Anorexia. High health risk, weight gain and treatment of anorexia are recommended."
        } else if bmi >= 17.5 && bmi <= 19.4 {
            descriptionBMI = "Lack of body weight. There is no risk to health."
        } else if bmi >= 19.5 && bmi <= 25.9 {
            descriptionBMI = "Norm. Weight loss is not required."
        } else if bmi >= 26 && bmi <= 27.9 {
        descriptionBMI = "Excess weight. Increased health risk, weight loss recommended."
        } else if bmi >= 28 && bmi <= 30.9 {
        descriptionBMI = "Grade I obesity. Increased health risk, recommended weight loss."
        } else if bmi >= 31 && bmi <= 35.9 {
        descriptionBMI = "Grade II obesity. High health risk. Weight loss is strongly recommended."
        } else if bmi >= 36 && bmi <= 40.9 {
        descriptionBMI = "Grade III obesity. Very high health risk. Weight loss is strongly recommended."
        } else if bmi >= 41 {
        descriptionBMI = "Grade IV obesity. Extremely high health risk. Weight loss is strongly recommended."
        }
        
        return descriptionBMI
    }
    // 4.
    
    // 5.
    private func getColorBMI(bmi: Double) -> UIColor {
        
        var colorBMI = UIColor.clear
        if bmi < 17.5 {
            colorBMI = UIColor.init(red: 0, green: 162/255, blue: 255/255, alpha: 1)
        } else if bmi >= 17.5 && bmi <= 19.4 {
            colorBMI = UIColor.init(red: 86/255, green: 193/255, blue: 255/255, alpha: 1)
        } else if bmi >= 19.5 && bmi <= 25.9 {
            colorBMI = UIColor.init(red: 97/255, green: 216/255, blue: 54/255, alpha: 1)
        } else if bmi >= 26 && bmi <= 27.9 {
            colorBMI = UIColor.init(red: 246/255, green: 186/255, blue: 0, alpha: 1)
        } else if bmi >= 28 && bmi <= 30.9 {
            colorBMI = UIColor.init(red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        } else if bmi >= 31 && bmi <= 35.9 {
            colorBMI = UIColor.init(red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        } else if bmi >= 36 && bmi <= 40.9 {
            colorBMI = UIColor.init(red: 238/255, green: 34/255, blue: 12/255, alpha: 1)
        } else if bmi >= 41 {
            colorBMI = UIColor.init(red: 181/255, green: 23/255, blue: 0, alpha: 1)
        }
        
        return colorBMI
    }
    // 5.
}

