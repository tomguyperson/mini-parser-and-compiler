//
//  SummaryViewController.swift
//  hw1
//
//  Created by Tommy Mesquita on 4/9/22.
//

import UIKit

class SummaryViewController: UIViewController {

    var m: Model?
    
    
    @IBOutlet weak var warning: UILabel!
    @IBOutlet weak var bloodPressureLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var bloodSugarLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if m!.isFull()
        {
            weightLabel.text = "\(m!.healthTracker[0].bodyWeight!)"
            bloodSugarLabel.text = "\(m!.healthTracker[0].bloodSugar!)"
            bloodPressureLabel.text = m!.healthTracker[0].getBloodPressure()
            
            warning.text = ""
        }
        else
        {
            weightLabel.text = ""
            bloodSugarLabel.text = ""
            bloodPressureLabel.text = ""
            
            warning.text = "Please enter data for all days of the week first. Days currently missing:" + m!.daysMissing()
        }
            
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSegmentChange(_ sender: UISegmentedControl) {
        
        if m!.isFull()
        {
            weightLabel.text = "\(m!.healthTracker[sender.selectedSegmentIndex].bodyWeight!)"
            bloodSugarLabel.text = "\(m!.healthTracker[sender.selectedSegmentIndex].bloodSugar!)"
            bloodPressureLabel.text = "\(m!.healthTracker[sender.selectedSegmentIndex].getBloodPressure())"
        }
        else{
            //do nothing
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
