//
//  part2VC.swift
//  lab1
//
//  Created by Tommy Mesquita on 1/30/22.
//

import UIKit

class part2VC: UIViewController {

    @IBOutlet weak var heightSlide: UISlider!
    
    @IBOutlet weak var weightSlide: UISlider!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var message: UILabel!
    
    var height:Float = 60
    var weight:Float = 120
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightLabel.text = "\(heightSlide.value)"
        weightLabel.text = "\(weightSlide.value)"
        
        height = heightSlide.value
        weight = weightSlide.value
        
        let bmi:Float = ((weight)/(height * height)) * 703
        
        bmiLabel.text = "\(bmi)"
        
        message.text = "You are Normal"
        message.textColor = UIColor.green
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func calcNewHeight(_ sender: Any) {
        heightLabel.text = "\(heightSlide.value)"
        
        height = heightSlide.value
        weight = weightSlide.value
        
        let bmi:Float = ((weight)/(height * height)) * 703
        
        bmiLabel.text = "\(bmi)"
        
        if bmi < 18 {
            message.text = "You are underweight"
            message.textColor = UIColor.blue
            message.isHidden = false
        }
        else if bmi < 25 {
            message.text = "You are normal"
            message.textColor = UIColor.green
            message.isHidden = false
        }
        else if bmi < 30 {
            message.text = "You are pre-obese"
            message.textColor = UIColor.purple
            message.isHidden = false
        }
        else{
            message.text = "You are obese"
            message.textColor = UIColor.red
            message.isHidden = false
        }
        
    }
    
    @IBAction func calcNewWeight(_ sender: Any) {
        weightLabel.text = "\(weightSlide.value)"
        
        height = heightSlide.value
        weight = weightSlide.value
        
        let bmi:Float = ((weight)/(height * height)) * 703
        
        bmiLabel.text = "\(bmi)"
        
        if bmi < 18 {
            message.text = "You are underweight"
            message.textColor = UIColor.blue
            message.isHidden = false
        }
        else if bmi < 25 {
            message.text = "You are normal"
            message.textColor = UIColor.green
            message.isHidden = false
        }
        else if bmi < 30 {
            message.text = "You are pre-obese"
            message.textColor = UIColor.purple
            message.isHidden = false
        }
        else{
            message.text = "You are obese"
            message.textColor = UIColor.red
            message.isHidden = false
        }
    }
    
    
    
    
}
