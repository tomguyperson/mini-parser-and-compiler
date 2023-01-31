//
//  ViewController.swift
//  Lab7
//
//  Created by Tommy Mesquita on 3/30/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityName: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var latlonlabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func displayInformation(_ sender: Any)
    {
        
    }
    
    func loadPlease()
    {
        let url = URL(string: self.url!)!
        
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url, completionHandler: { data, response, error -> Void in
            if (error != nil) {
                print(error!.localizedDescription)
            }
            
            var err: NSError?
            
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(earthquakes.self, from: data!)
            print(jsonResult)
            
            if (err != nil) {
                print("JSON Error (err!.localizedDescription)")
            }
            
            self.earthquakeItems = jsonResult.earthquakes
            
            DispatchQueue.main.async(execute: {
                self.newsTable.reloadData()
            })
        })
        jsonQuery.resume()
    }
    
}

