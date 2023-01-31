//
//  jupiterViewController.swift
//  Lab2
//
//  Created by Tommy Mesquita on 2/6/22.
//

import UIKit

class jupiterViewController: UIViewController {

    var weight: Float?
    var moonWeight: Float?
    var jupiterWeight: Float?
    
    @IBOutlet weak var earthWeightText: UILabel!
    
    @IBOutlet weak var moonWeightText: UILabel!
   
    @IBOutlet weak var jupiterWeightText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        earthWeightText.text = "Your weight on Earth is \(weight!)"
        
        moonWeight = weight!/6
        
        moonWeightText.text = "Your weight on the moon is \(moonWeight!)"
        
        jupiterWeight = weight!*2.4
        
        jupiterWeightText.text = "Your weight on Jupiter is \(jupiterWeight!)"
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "MtoJ")
        {
            let dest = segue.destination as! moonViewController
            dest.weight = weight
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
