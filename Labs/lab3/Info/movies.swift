//
//  movies.swift
//  lab3
//
//  Created by Tommy Mesquita on 2/14/22.
//

import Foundation
class movieRecord
{
    var title:String? = nil
    var genre:String? = nil
    var sale:Int64? = nil
    
    init(t:String, g:String, s:Int64) {
        self.title = t
        self.genre = g
        self.sale = s
    }
    
    func change_sale(newSale:Int64)
    {
        self.sale = newSale;
    }
    
}
