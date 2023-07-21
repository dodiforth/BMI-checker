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
    
    // 버튼을 누르면 다음화면으로 이동하는 segue(직접)을 호출
    // Press the button to call the Segue for another view
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        //다음화면으로 넘어갈지 말지를 결정하는 로직을 짜면됨
        //EN) Determins whether the segue with the specified identifier should be performed.
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "Type the height and the weight!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "Type your height and weight"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 데이터 전달을 위해 구현해야하는 세그웨이
    // Segue to pass data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //데이터 전달
        //Passing data
        if segue.identifier == "toSecondVC" {
            
           let secondVC = segue.destination as! SecondViewController
            secondVC.modalPresentationStyle = .fullScreen
            
            //transfer the output of the user's BMI result
            secondVC.bmi = bmiManager.getBMI(height: heightTextField.text!, weight: weightTextField.text!)
        }
        
        //다음화면으로 가기전에 텍스트필드 비우기
        //Empty textFields before moving on another view
        heightTextField.text = ""
        weightTextField.text = ""
        
    }
    
   
    
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if Int(string) != nil || string == "" {
            return true // 글자입력을 허용 let user to type
        }
        return false // 글자입력 불허용 don't let user to type
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        // Finish typing on the two textFields
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // 두번째 텍스트필드로 넘어가도록
        // moving onto second textField(weight)
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
        
        
    }
    
    // 뷰의 여백공간 클릭시 키보드 내려감
    // Touch blanks to lower the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}
