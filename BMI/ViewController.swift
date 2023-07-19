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
    
    var bmi: Double?
    
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
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        // output the reult of user's BMI
        
        guard let height = heightTextField.text,
              let weight = weightTextField.text else {return}
        
        bmi = calculateBMI(height: height, weight: weight)
        
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
           //transfer the output of the user's BMI result
            secondVC.bmiNumber = self.bmi
            secondVC.bmiColor = getBackbroundColour()
            secondVC.adviceString = getBMIAdviceString()
            
            
        }
        
        //다음화면으로 가기전에 텍스트필드 비우기
        //Empty textFields before moving on another view
        heightTextField.text = ""
        weightTextField.text = ""
        
    }
    
    // BMI calculation method
    func calculateBMI(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else {return 0.0}
        var bmi = w / (h * h) * 10000
        print("BMI RESULT(반올림하기전) : \(bmi)")
        bmi = round( bmi * 10 ) / 10
        print("BMI RESULT(반올림한후) : \(bmi)")
        return bmi
    }
    
    // Get background colour method
    func getBackbroundColour() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    //get string according to bmi method
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi{
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    
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
