//
//  StartViewController.swift
//  Lab7
//
//  Created by Tommy Mesquita on 4/1/22.
//  Copyright © 2022 ASU. All rights reserved.
//

import UIKit
import MapKit

class StartViewController: UIViewController {

    @IBOutlet weak var cityNameField:UITextField?
    
    @IBOutlet weak var cityDescription: UILabel!
    
    var urlAsString: String?
    var latlon: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityDescription.text = ""

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "gogogaget"){
            if let viewController: ViewController = segue.destination as? ViewController {
                findLatLon()
                viewController.cityName = cityNameField?.text;
                viewController.newURL = urlAsString
            }
        }
    }
    
    
    @IBAction func showLatLon(_ sender: Any) {
        findLatLon()
    }
    
    func findLatLon()
    {
        let geoCoder = CLGeocoder();

        CLGeocoder().geocodeAddressString((cityNameField?.text!)!, completionHandler:
                                            {(placemarks, error) in

            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                print(location)
                
                let north = (placemark.location?.coordinate.latitude)! + 10
                let south = (placemark.location?.coordinate.latitude)! - 10
                let east = (placemark.location?.coordinate.longitude)! + 10
                let west = (placemark.location?.coordinate.longitude)! - 10
                
                self.cityDescription.text = "lat: \((placemark.location?.coordinate.latitude)!) \nlon: \((placemark.location?.coordinate.longitude)!)"
                self.urlAsString = "http://api.geonames.org/earthquakesJSON?north=\(north)&south=\(south)&east=\(east)&west=\(west)&username=tmesqui1"
            }
        })
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
