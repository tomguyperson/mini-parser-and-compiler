//
//  DetailViewController.swift
//  Lab4
//
//  Created by Tommy Mesquita on 2/28/22.
//

import Foundation
import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    var selectedCity:city?
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var warn: UILabel!
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var mapTime: MKMapView!
    //    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cityName.text = selectedCity?.cityName
        self.warn.text = ""
        
        let geoCoder = CLGeocoder();
        
        CLGeocoder().geocodeAddressString((selectedCity?.cityName)!, completionHandler:
                                            {(placemarks, error) in
            
            if error != nil {
                print("Geocode failed: \(error!.localizedDescription)")
            } else if placemarks!.count > 0 {
                let placemark = placemarks![0]
                let location = placemark.location
                print(location)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.mapTime.setRegion(region, animated: true)
                
                self.cityDescription.text = "lat: \((placemark.location?.coordinate.latitude)!) \nlon: \((placemark.location?.coordinate.longitude)!)"
            }
        })
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        if let newRequest = searchBar.text
        {
            warn.text = ""
            
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = newRequest
            
            request.region = self.mapTime.region
            let search = MKLocalSearch(request: request)
            
            var matchingItems:[MKMapItem] = []
            
            search.start { response, _ in
                guard let response = response else {
                    return
                }
                print( response.mapItems )
                
                matchingItems = response.mapItems
                for i in 1...matchingItems.count - 1
                {
                    let place = matchingItems[i].placemark
                    print(place.name)
                    
                }
                
                self.ShowLocation(matchingItems: matchingItems)
            }
            
        }
        else
        {
            warn.text = "Please Enter Address to Search"
        }
        
    }
    
    func ShowLocation( matchingItems:[MKMapItem] ) {
        
        for i in 0...matchingItems.count - 1
        {
            let address = matchingItems[i].placemark.location
            
            let ani = MKPointAnnotation()
            ani.coordinate = address!.coordinate
            ani.title = matchingItems[i].placemark.name
            self.mapTime.addAnnotation(ani)
            
        }
    }
    @IBAction func switchMapView(_ sender: Any) {
        
        switch(segmentedController.selectedSegmentIndex)
        {
        case 0:
            mapTime.mapType = MKMapType.standard
            
        case 1:
            mapTime.mapType = MKMapType.satellite
            
        default:
            mapTime.mapType = MKMapType.standard
        }
        
    }
}
