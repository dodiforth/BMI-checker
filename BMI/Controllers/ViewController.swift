//
//  ViewController.swift
//  BMI
//
//  Created by Dowon Kim on 17/07/2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var calculateButton: UIButton!
     
    // an instance to communicate with BMICalculatorManager
    var bmiManager = BMICalculatorManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        
        mainLabel.text = "Type your height and weight"
        heightTextField.placeholder = "Your height in cm"
        weightTextField.placeholder = "Your weight in kg"

        //make the burron's corner round
        calculateButton.clipsToBounds = true
        calculateButton.layer.cornerRadius = 5
        
        calculateButton.setTitle("Calculate BMI", for: .normal)
        
    }
    
    // Press the button to calculate BMI value 
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        
        
    }
    
    // Press the button to call the Segue for another view
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Decide whether the segue with the specified identifier should be performed.
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "Type the height and the weight!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "Type your height and weight"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // Segue to pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Passing data
        if segue.identifier == "toSecondVC" {
            
           let secondVC = segue.destination as! SecondViewController
            secondVC.modalPresentationStyle = .fullScreen
            
            //transfer the output of the user's BMI result
            secondVC.bmi = bmiManager.getBMI(height: heightTextField.text!, weight: weightTextField.text!)
        }
        
        //Empty textFields before moving on another view
        heightTextField.text = ""
        weightTextField.text = ""
        
    }
    
   
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if Int(string) != nil || string == "" {
            return true // let user to type
        }
        return false // don't let user to type
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Finish typing on the two textFields (lowing virtual keyboard)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // moving onto second textField(weight)
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
        
        
    }
    
    // Touch blanks to lower virtual keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}
