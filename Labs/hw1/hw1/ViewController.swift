//
//  ViewController.swift
//  hw1
//
//  Created by Tommy Mesquita on 4/9/22.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    var m: Model?

    @IBOutlet weak var enterDataButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "enterDataSegue"){
            if let viewController: EnterDataViewController = segue.destination as? EnterDataViewController {
                viewController.m = m;
            }
        }
        
        else if(segue.identifier == "summarySegue"){
            if let viewController: SummaryViewController = segue.destination as? SummaryViewController {
                viewController.m = m;
            }
        }
        
        else if(segue.identifier == "atRiskSegue"){
            if let viewController: AtRiskViewController = segue.destination as? AtRiskViewController {
                viewController.m = m;
            }
        }
        
        
        
    }
    
}

