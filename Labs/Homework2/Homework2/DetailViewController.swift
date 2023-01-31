//
//  DetailViewController.swift
//  Homework2
//
//  Created by Tommy Mesquita on 4/23/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var selectedCity:city?
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cityDescription.text = selectedCity?.cityDescription
        self.cityName.text = selectedCity?.cityName
        self.cityImage.image = UIImage(named:(selectedCity?.cityImageName)!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
