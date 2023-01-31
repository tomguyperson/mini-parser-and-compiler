//
//  HealthInfo.swift
//  hw1
//
//  Created by Tommy Mesquita on 4/9/22.
//

import Foundation

class HealthInfo
{   
    var bloodSugar: Float?
    var bodyWeight: Float?
    var systolic: Int?
    var diastolic: Int?
    var symptoms: String?
    
    init(bloodSugar: Float?, bodyWeight: Float?, systolic: Int?, diastolic: Int?, symptoms: String?)
    {
        self.bloodSugar = bloodSugar
        self.bodyWeight = bodyWeight
        self.systolic = systolic
        self.diastolic = diastolic
        self.symptoms = symptoms
    }
        
    func getBloodPressure() -> String
    {
        return "\(systolic!) / \(diastolic!)"
    }
    
}
