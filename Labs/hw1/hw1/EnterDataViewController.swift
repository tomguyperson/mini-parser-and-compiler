//
//  EnterDataViewController.swift
//  hw1
//
//  Created by Tommy Mesquita on 4/9/22.
//

import UIKit

class EnterDataViewController: UIViewController {
    
    var m: Model?
    
    @IBOutlet weak var dayController: UISegmentedControl!
    
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var bloodSugarField: UITextField!
    
    @IBOutlet weak var systolicField: UITextField!
    @IBOutlet weak var diastolicField: UITextField!
    
    @IBOutlet weak var symptomsField: UITextField!
    
    @IBOutlet weak var updatesLabel: UILabel!
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        printAll()
        
        updatesLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveChanges(_ sender: Any)
    {
        if bloodSugarField.text != "",
           systolicField.text != "",
           diastolicField.text != "",
           weightField.text != ""
        {
            m!.healthTracker[currentIndex].bloodSugar = Float(bloodSugarField.text!)
            m!.healthTracker[currentIndex].bodyWeight = Float(weightField.text!)
            m!.healthTracker[currentIndex].systolic = Int(systolicField.text!)
            m!.healthTracker[currentIndex].diastolic = Int(diastolicField.text!)
            m!.healthTracker[currentIndex].symptoms = symptomsField.text!
            
            //print(currentIndex)
            
            self.updatesLabel.textColor = UIColor.green
            self.updatesLabel.text = "Updated!"
        }
        else{
            self.updatesLabel.textColor = UIColor.red
            self.updatesLabel.text = "Please fill in fields"
        }
    }
    
    @IBAction func segmentChange(_ sender: UISegmentedControl) {
        self.bloodSugarField.text = ""
        self.systolicField.text = ""
        self.diastolicField.text = ""
        self.weightField.text = ""
        self.symptomsField.text = ""
        
        updatesLabel.text = ""
        
        currentIndex = sender.selectedSegmentIndex
    }
    
    func printAll()
    {
        for i in 0...6
        {
            print((m!.healthTracker[i].bloodSugar)!)
        }
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
