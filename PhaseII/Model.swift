//
//  Model.swift
//  PhaseII
//
//  Created by Tommy Mesquita on 4/18/22.
//

import Foundation
import CoreData
public class Model{
    let managedObjectContext:NSManagedObjectContext?
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
        
        // Getting a handler to the coredata managed object context
    }
    
    func saveRecord()
    {
        do {
            try managedObjectContext?.save()
        } catch {
            print("!!Error while saving the new image!!")
        }
    }
    
    func findRecord(name: String) ->NSManagedObject?
    {
        // retrun data
        var match:NSManagedObject?
        // get a handler to the contact entity
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "City",
                                       in: managedObjectContext!)
        // create a fetch request
        let request: NSFetchRequest<City> = City.fetchRequest() as! NSFetchRequest<City>
        
        // associate the request with contact handler
        request.entity = entityDescription
        
        // build the search request predicate (query)
        let pred = NSPredicate(format: "(name = %@)", name)
        request.predicate = pred
        
        // perform the query and process the query results
        do {
            var results =
                try managedObjectContext!.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)
            
            if results.count > 0 {
                 match = results[0] as! NSManagedObject
                 //return match
            } else {
                //return match
            }
            
        } catch let error {
            print(error.localizedDescription )
        }
        
        return match
        
    }
    
    func clearData()
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
        // performs the batch delete for the contact
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext!.execute(deleteRequest)
            try managedObjectContext!.save()
            
        }
        catch let _ as NSError {
            // Handle error
        }
        
        
    }
    func SaveContext(name: String, desc: String, image: Data) -> City
    {
        // get a handler to the Contacts entity through the managed object context
        let ent = NSEntityDescription.entity(forEntityName: "City", in: self.managedObjectContext!)
        
        // create a contact object instance for insert
        let city = City(entity: ent!, insertInto: managedObjectContext)
        
        // add data to each field in the entity
        city.name = name
        city.picture = image
        city.details = desc
//        city.cityImageName = ""
        
        // save the new entity
        do {
            try managedObjectContext!.save()
            print("City Saved")
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        return city
    }
    
    func fetchRecord() -> [City] {
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "City")
//        let sort = NSSortDescriptor(key: "name", ascending: true)
//        fetchRequest.sortDescriptors = [sort]
//        var x   = 0
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        let fetched = ((try? self.managedObjectContext!.fetch(fetchRequest)) as? [City])!
        
        
//        x = myCityList.cities.count
//
//        print(x)
//
        // return howmany entities in the coreData
        return fetched
    }
    
}
