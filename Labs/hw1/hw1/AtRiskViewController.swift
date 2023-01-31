//
//  AtRiskViewController.swift
//  hw1
//
//  Created by Tommy Mesquita on 4/9/22.
//

import UIKit

class AtRiskViewController: UIViewController {

    @IBOutlet weak var weightIncreaseLabel: UILabel!
    @IBOutlet weak var bloodSugarLabel: UILabel!
    @IBOutlet weak var bloodPressureLabel: UILabel!
    @IBOutlet weak var allGoodLabel: UILabel!
    

    var m: Model?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weightIncreaseLabel.text = ""
        bloodSugarLabel.text = ""
        bloodPressureLabel.text = ""
        allGoodLabel.text = ""
        
        if(m!.isFull())
        {
            if m!.gainingWeight()
            {
                weightIncreaseLabel.text = "You are gaining weight!"
            }
            
            if m!.highBloodSugar()
            {
                bloodSugarLabel.text = "Your sugar level is high!"
            }
            
            if m!.highBloodPressure()
            {
                bloodPressureLabel.text = "Your blood pressure is high!"
            }
            
            if !m!.gainingWeight() && !m!.highBloodSugar() && !m!.highBloodPressure()
            {
                allGoodLabel.text = "You are in good health! Keep it up! :)"
            }
        }
        else
        {
            allGoodLabel.text = "Please fill out all data to determine if you are at risk"
        }
        
            
        
        // Do any additional setup after loading the view.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
