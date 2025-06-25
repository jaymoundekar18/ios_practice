//
//  MyTabViewController1.swift
//  Practice
//
//  Created by Chandra Hasan on 16/06/25.
//

import UIKit

class MyTabViewController1: UIViewController {

    @IBOutlet var homeIcon: UITabBarItem!
    
    @IBOutlet var bmiResult: UILabel!
    
    @IBOutlet var heightSlider: UISlider!
    
    @IBOutlet var weightSlider: UISlider!
    
    @IBOutlet var calculateBtn: UIButton!
    
    @IBOutlet var heightLabel: UILabel!
    
    @IBOutlet var weightLabel: UILabel!
    
    @IBOutlet var suggestLabel: UILabel!
    
    
    var height: Float = 0.0
    
    var weight: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func heightSliderChange(_ sender: UISlider) {
        height = sender.value
        heightLabel.text = String(format: "%.2f", sender.value) + " (m)"
//        print(sender.value)
    }
    
    @IBAction func weightSliderChange(_ sender: UISlider) {
        weight = Int(sender.value)
        weightLabel.text = String(Int(sender.value)) + " (kg)"
//        print(Int(sender.value))
    }
    
    @IBAction func calculateBMI(_ sender: Any) {
        
        let heightSq = height * height
        
        let bmi = Float(weight) / heightSq
        
        bmiResult.text = String(format: "%.2f", bmi)
//        print("BMI is : \(String(describing: bmiResult.text))")
        
        if (bmi < 18.5){
            suggestLabel.text = "You are UNDERWEIGHT"
            suggestLabel.textColor = .yellow
            bmiResult.textColor = .yellow
        }
        else if (bmi >= 18.5) && (bmi <= 24.9){
            suggestLabel.text = "You are NORMAL"
            suggestLabel.textColor = .systemGreen
            bmiResult.textColor = .systemGreen
        }
        else if (bmi > 24.9) && (bmi <= 29.9){
            suggestLabel.text = "You are OVERWEIGHT"
            suggestLabel.textColor = .orange
            bmiResult.textColor = .orange
        }
        else if (bmi > 29.9) && (bmi <= 34.9){
            suggestLabel.text = "You are OBESE"
            suggestLabel.textColor = .orange
            bmiResult.textColor = .orange
            
        }else{
            suggestLabel.text = "You are EXTERMELY OBESE"
            suggestLabel.textColor = .red
            bmiResult.textColor = .red
        }
        
    }
    
}
