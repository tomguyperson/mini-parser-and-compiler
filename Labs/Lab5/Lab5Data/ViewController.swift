//
//  ViewController.swift
//  tableViewCoreData
//
//  Created by Tommy Mesquita on 3/16/22.
//  Copyright © 2022 ASU. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var cityTable: UITableView!
    
    var empty:Data = Data()

    var counter = 1
    
    var m:Model?
    
    // handler to the managege object context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //this is the array to store Fruit entities from the coredata
    var   fetchResults =   [City]()
    
    override func viewDidLoad() {
        initCounter()
        m = Model(context: managedObjectContext)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.cityTable.indexPath(for: sender as! UITableViewCell)!
        
        let city = fetchResults[selectedIndex.row]
        
        if(segue.identifier == "detailView"){
            if let viewController: DetailViewController = segue.destination as? DetailViewController {
                viewController.selectedCity = city;
                viewController.m = m;
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // number of rows based on the coredata storage
        fetchResults = m!.fetchRecord()
        
        return fetchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // add each row from coredata fetch results
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) 
        cell.layer.borderWidth = 1.0
        cell.textLabel?.text = fetchResults[indexPath.row].name
        cell.detailTextLabel?.text = fetchResults[indexPath.row].details
        
        if let picture = fetchResults[indexPath.row].picture {
            cell.imageView?.image =  UIImage(data: picture as Data)
        } else {
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
    // delete table entry
    // this method makes each row editable
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    // return the table view style as deletable
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell.EditingStyle { return UITableViewCell.EditingStyle.delete }
    
    // implement delete function
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if editingStyle == .delete
        {
            
            // delete the selected object from the managed
            // object context
            self.m!.managedObjectContext?.delete(fetchResults[indexPath.row])
            // remove it from the fetch results array
            fetchResults.remove(at:indexPath.row)
            
            do {
                // save the updated managed object context
                try self.m!.saveRecord()//managedObjectContext?.save()
            } catch {
                
            }
            // reload the table after deleting a row
            cityTable.reloadData()
        }
    }
    
    @IBAction func addARecord(_ sender: UIBarButtonItem) {
        // create a new entity object
        let ent = NSEntityDescription.entity(forEntityName: "City", in: self.m!.managedObjectContext!)
        //add to the manege object context
        
        // one more item added
        updateCounter()
        
        let newItem = City(entity: ent!, insertInto: self.m!.managedObjectContext)
        
        let picker = UIImagePickerController ()
        // show the alert controller to select an image for the row
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the City Here"
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Short Description of the City Here"
        })
        
        let serachAction = UIAlertAction(title: "Choose Picture", style: .default) { (aciton) in
            // load image
            
            if let cname = alertController.textFields?[0].text, let descrip = alertController.textFields?[1].text
            {
                print("city name: \(cname)")
                
                newItem.name = cname
                newItem.details = descrip
//                newItem.picture = nil
                
                do {
                    try self.m!.saveRecord()//managedObjectContext?.save()
                } catch _ {
                }
                
                picker.delegate = self
                picker.sourceType = .photoLibrary
                // display image selection view
                self.present(picker, animated: true, completion: nil)
            }           
        }
        
        let takeAction = UIAlertAction(title: "Take Picture", style: .default) { (aciton) in
            
            if let cname = alertController.textFields?[0].text, let descrip = alertController.textFields?[1].text
            {
                print("city name: \(cname)")
                
                newItem.name = cname
                newItem.details = descrip
//                newItem.picture = nil
                
                do {
                    try self.m!.saveRecord()//managedObjectContext?.save()
                } catch _ {
                }
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    picker.allowsEditing = false
                    picker.sourceType = UIImagePickerController.SourceType.camera
                    picker.cameraCaptureMode = .photo
                    picker.modalPresentationStyle = .fullScreen
                    self.present(picker,animated: true,completion: nil)
                } else {
                    print("No camera")
//                    self.updateCounter()
                    self.cityTable.reloadData()
                }
            }
        }
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        
        alertController.addAction(serachAction)
        alertController.addAction(takeAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
        //newItem.picture =
        
        // save the updated context
        do {
            try self.m!.saveRecord()//managedObjectContext?.save()
        } catch _ {
        }
        
        print(newItem)
        // reload the table with added row
        // this happens before getting the image, so first we add the row
        // without the image and then add the image
        cityTable.reloadData()
        self.updateLastRow()
    }
    
    func updateLastRow() {
        let indexPath = IndexPath(row: fetchResults.count - 1, section: 0)
        cityTable.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func initCounter() {
        counter = UserDefaults.init().integer(forKey: "counter")
    }
    
    func updateCounter() {
        counter += 1
        UserDefaults.init().set(counter, forKey: "counter")
        UserDefaults.init().synchronize()
    }
    
    
    @IBAction func deleteAll(_ sender: UIBarButtonItem) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        
        // whole fetchRequest object is removed from the managed object context
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try m!.managedObjectContext?.execute(deleteRequest)
            try m!.saveRecord()//managedObjectContext?.save()
        }
        catch let _ as NSError {
            // Handle error
        }
        
        cityTable.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        picker .dismiss(animated: true, completion: nil)

        // fetch resultset has the recently added row without the image
        // this code ad the image to the row
        if let fruit = fetchResults.last, let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            fruit.picture = image.pngData()! as Data
            //update the row with image
            updateLastRow()
            do {
                try m!.saveRecord()//m!.managedObjectContext?.save()
            } catch {
                print("Error while saving the new image")
            }
            
        }
        cityTable.reloadData()
    }
}
