//
//  SecondViewController.swift
//  BMI
//
//  Created by Dowon Kim on 17/07/2023.
//

import UIKit

class SecondViewController: UIViewController {

    
    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var bmiNumber: Double?
    var adviceString: String?
    var bmiColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
    }
    
    func makeUI(){
        //make the burron's corner round
        backButton.clipsToBounds = true
        backButton.layer.cornerRadius = 5
        backButton.setTitle("again", for: .normal)
            
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        bmiNumberLabel.backgroundColor = .gray
        
        guard let bmi = bmiNumber else { return }
        bmiNumberLabel.text = String(bmi)
        
        adviceLabel.text = adviceString
        bmiNumberLabel.backgroundColor = bmiColor
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    

}
