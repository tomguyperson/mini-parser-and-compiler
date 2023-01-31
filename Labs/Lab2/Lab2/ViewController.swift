//
//  ViewController.swift
//  Lab2
//
//  Created by Tommy Mesquita on 2/6/22.
//

import UIKit

class ViewController: UIViewController {

    //var weight: Int?
    
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var from: UILabel!
    
    @IBOutlet weak var earthImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        from.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "EtoM")
        {
            let dest = segue.destination as! moonViewController
            dest.weight = Float(weightField.text!)
        }
    }
    
    @IBAction func returnFromMoon (segue: UIStoryboardSegue)
    {
        
        from.text = "Coming from the moon"
        from.isHidden = false
//        if let sourceViewController = segue.source as? moonViewController
//        {
//            let dataRecv = sourceViewController.data
//            
//        }
    }
    
    @IBAction func returnFromJupiterToEarth (segue: UIStoryboardSegue)
    {
        from.text = "Coming from Jupiter"
        from.isHidden = false
//        if let sourceViewController = segue.source as? moonViewController
//        {
//            let dataRecv = sourceViewController.data
//
//        }
    }
    
    
}

