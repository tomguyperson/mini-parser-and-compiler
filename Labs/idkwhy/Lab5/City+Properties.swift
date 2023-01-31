//
//  City+Properties.swift
//  tableViewCoreData
//
//  Created by Tommy Mesquita on 3/16/22.
//  Copyright © 2022 ASU. All rights reserved.
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
