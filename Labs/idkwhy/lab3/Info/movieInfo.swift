//
//  movieInfo.swift
//  lab3
//
//  Created by Tommy Mesquita on 2/14/22.
//

import Foundation
class movieInfo
{
    // dictionary that stores person records
    var infoRepository : [String:movieRecord] = [String:movieRecord] ()
    init() { }
  
    func add(_ title:String, _ genre:String, _ sale:Int64)
    {
        let mRecord =  movieRecord(t:title, g:genre, s:sale)
        infoRepository[mRecord.title!] = mRecord
    }
    
    func add(m:movieRecord)
    {
        print("adding" + m.title!)
        infoRepository[m.title!] = m
        
    }
    
    func search(t:String) -> movieRecord?
    {
        var found = false
        
        for (title, _) in infoRepository
        {
            if title == t {
            found = true
                break
            }
        }
        if found
        {
           return infoRepository[t]
        }else  {
     
            return nil
            }
    }
    
    func deleteRec(t:String)
    {
        infoRepository[t] = nil
    }
}
