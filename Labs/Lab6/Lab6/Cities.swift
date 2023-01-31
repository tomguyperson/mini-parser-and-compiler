//
//  Cities.swift
//  Lab4
//
//  Created by Tommy Mesquita on 2/28/22.
//

import Foundation
class cities
{
    var cities:[city] = []
    
    init()
    {
        let f1 = city(fn: "New York", fd: "City with Beautiful Skyline", fin: "new york.jpeg")
        let f2 = city(fn: "Berlin", fd: "Great place for worker's rights", fin: "berlin.jpeg")
        let f3 = city(fn: "Sao Paulo", fd: "Like Los Angeles but in Brazil", fin: "sao paulo.jpeg")
        let f4 = city(fn: "Dubai", fd: "Home to the tallest building in the world", fin: "dubai.jpeg")
        let f5 = city(fn: "Seoul", fd: "I love korean barbecue", fin: "seoul.jpeg")
        
        cities.append(f1)
        cities.append(f2)
        cities.append(f3)
        cities.append(f4)
        cities.append(f5)
    }
    
    func getCount() -> Int
    {
        return cities.count
    }
    
    func getCityObject(item:Int) -> city{
        
        return cities[item]
    }
    
    func removeCityObject(item:Int) {
        
         cities.remove(at: item)
    }
    
    func addCityObject(name:String, desc: String, image: String) -> city{
        let f = city(fn: name, fd: desc, fin: "city.jpeg")
        cities.append(f)
        return f
    }
    
}
class city
{
    var cityName:String?
    var cityDescription:String?
    var cityImageName:String?
    
    init(fn:String, fd:String, fin:String)
    {
        cityName = fn
        cityDescription = fd
        cityImageName = fin
        
    }
}
