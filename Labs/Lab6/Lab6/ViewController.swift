//
//  ViewController.swift
//  Lab4
//
//  Created by Tommy Mesquita on 2/28/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //model
    var myCityList:cities =  cities()
    
    @IBOutlet weak var cityTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCityList.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "fruitCell", for: indexPath) as! CityTableViewCell
        cell.layer.borderWidth = 1.0
        
        let cityItem = myCityList.getCityObject(item:indexPath.row)
        
        cell.cityTitle.text = cityItem.cityName;
        //cell.cityDescription.text = cityItem.cityDescription
    
        cell.cityImage.image = UIImage(named: cityItem.cityImageName!)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        myCityList.removeCityObject(item: indexPath.row)

        self.cityTable.beginUpdates()
        self.cityTable.deleteRows(at: [indexPath], with: .automatic)
        self.cityTable.endUpdates()

        
    }

    @IBAction func refreash(_ sender: AnyObject) {
      
        
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
//        alert.addTextField(configurationHandler: { textField in
//            textField.placeholder = "Enter Short Description of the City Here"
//        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         
            if let name = alert.textFields?[0].text {
                print("city name: \(name)")

                self.myCityList.addCityObject(name: name, desc: "", image: "city.jpeg")
                

                let indexPath = IndexPath (row: self.myCityList.getCount() - 1, section: 0)
                self.cityTable.beginUpdates()
                self.cityTable.insertRows(at: [indexPath], with: .automatic)
                self.cityTable.endUpdates()

            }
        }))
        
        self.present(alert, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let city = myCityList.getCityObject(item: selectedIndex.row)
        
        
        
        if(segue.identifier == "detailView"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedCity = city;
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}

