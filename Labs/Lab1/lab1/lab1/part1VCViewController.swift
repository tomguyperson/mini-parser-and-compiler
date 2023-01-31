//
//  part1VCViewController.swift
//  lab1
//
//  Created by Tommy Mesquita on 1/30/22.
//

import UIKit

class part1VCViewController: UIViewController {

    
    @IBOutlet weak var heightBox: UITextField!
    
    @IBOutlet weak var weightBox: UITextField!
    
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var calcButton: UIButton!
    
    @IBOutlet weak var message: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bmiLabel.isHidden = true
        message.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func calculate(_ sender: Any) {
        
        var height:Double = Double(heightBox.text!)!
        var weight:Double = Double(weightBox.text!)!
        
        var bmi:Double = ((weight)/(height * height)) * 703
        
        bmiLabel.text = "\(bmi)"
        bmiLabel.isHidden = false
        
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
