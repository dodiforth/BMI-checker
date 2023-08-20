//
//  BMICalculatorManager.swift
//  BMI
//
//  Created by Dowon Kim on 20/07/2023.
//

import UIKit

struct BMICalculatorManager {
    
    // a variable to keep the track data of BMI calculation.
    private var bmi: BMI?
    
    // Get BMI result
    mutating func getBMI(height: String, weight: String) -> BMI {
        // call calculateBMI method
        calculateBMI(height: height, weight: weight)
        // return BMI
        return bmi ?? BMI(value: 0.0, matchAdvice: "Error Occurred", matchColor: UIColor.white)
    }
    
    // Calculate BMI and make an instance of BMI Struct
    mutating private func calculateBMI(height: String, weight: String) {
        
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, matchAdvice: "Error Occurred", matchColor: UIColor.white)
            return
        }
        
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255,
                                green: 231/255,
                                blue: 207/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, matchAdvice: "UNDERWEIGHT", matchColor: color)
            
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255,
                                green: 251/255,
                                blue: 121/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, matchAdvice: "NORMAL", matchColor: color)
            
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255,
                                green: 127/255,
                                blue: 163/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, matchAdvice: "OVERWEIGHT", matchColor: color)
            
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255,
                                green: 150/255,
                                blue: 141/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, matchAdvice: "OBESE", matchColor: color)
            
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255,
                                green: 100/255,
                                blue: 78/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, matchAdvice: "EXTREMLY OBESE", matchColor: color)
            
        default:
            bmi = BMI(value: 0.0, matchAdvice: "Error Occurred", matchColor: .white)

        }
    }
    
    

    
}
