//
//  City+Properties.swift
//  PhaseII
//
//  Created by Tommy Mesquita on 4/18/22.
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var details: String?
    @NSManaged public var picture: Data?
    
}
