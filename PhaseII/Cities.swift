//
//  Cities.swift
//  PhaseII
//
//  Created by Tommy Mesquita on 4/18/22.
//

import Foundation
class cities
{
    var cities:[City] = []
    
    init()
    {
        let f1 = City()
        f1.name = "New York"
        f1.details = "City with Beautiful Skyline"
        f1.picture = Data()
//        let f2 = City(fn: "Berlin", fd: "Great place for worker's rights", fin: Data())
//        let f3 = City(fn: "Sao Paulo", fd: "Like Los Angeles but in Brazil", fin: Data())
//        let f4 = City(fn: "Dubai", fd: "Home to the tallest building in the world", fin: Data())
//        let f5 = City(fn: "Seoul", fd: "I love korean barbecue", fin: Data())

        cities.append(f1)
//        cities.append(f2)
//        cities.append(f3)
//        cities.append(f4)
//        cities.append(f5)
    }
    
    func getCount() -> Int
    {
        return cities.count
    }
    
    func getCityObject(item:Int) -> City{
        
        return cities[item]
    }
    
    func removeCityObject(item:Int) {
        
         cities.remove(at: item)
    }
    
    func addCityObject(name:String, desc: String, image: Data) -> City{
        let f = City()
        f.name = name
        f.details = desc
        f.picture = image
        cities.append(f)
        return f
    }
    
}
