//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by Dowon Kim on 20/07/2023.
//

import UIKit

struct BMICalculatorManager {
    
    // a variable to keep the track data of BMI calculation.
    var bmi: Double?
        
    // BMI calculation method
    mutating func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = 0.0
            return
        }
        var bmiNumber = w / (h * h) * 10000
//        print("BMI RESULT(반올림하기전) : \(bmi)")
        bmi = round( bmiNumber * 10 ) / 10
//        print("BMI RESULT(반올림한후) : \(bmi)")
    }
    
    func getBMIResult() -> Double {
        return bmi ?? 0.0
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
