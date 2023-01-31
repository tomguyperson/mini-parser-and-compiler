//
//  moonViewController.swift
//  Lab2
//
//  Created by Tommy Mesquita on 2/6/22.
//

import UIKit

class moonViewController: UIViewController {

    @IBOutlet weak var from: UILabel!
    var weight: Float?
    var moonWeight: Float?
    
    @IBOutlet weak var earthWeightText: UILabel!
    
    @IBOutlet weak var moonWeightText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        from.isHidden = true

        earthWeightText.text = "Your weight on Earth is \(weight!)"
        
        moonWeight = weight!/6
        
        moonWeightText.text = "Your weight on the moon is \(moonWeight!)"
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "MtoJ")
        {
            let dest = segue.destination as! jupiterViewController
            dest.weight = weight
        }
    }

    @IBAction func returnFromJupiter (segue: UIStoryboardSegue)
    {
        from.text = "Coming from Jupiter"
        from.isHidden = false
//        if let sourceViewController = segue.source as? moonViewController
//        {
//            let dataRecv = sourceViewController.data
//
//        }
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
