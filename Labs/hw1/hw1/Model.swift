//
//  Model.swift
//  hw1
//
//  Created by Tommy Mesquita on 4/9/22.
//

import Foundation

class Model
{
    var healthTracker: [HealthInfo] = []
 
    init()
    {
        let h1: HealthInfo = HealthInfo(bloodSugar: -1, bodyWeight: -1, systolic: -1, diastolic: -1, symptoms: "")
        let h2: HealthInfo = HealthInfo(bloodSugar: -1, bodyWeight: -1, systolic: -1, diastolic: -1, symptoms: "")
        let h3: HealthInfo = HealthInfo(bloodSugar: -1, bodyWeight: -1, systolic: -1, diastolic: -1, symptoms: "")
        let h4: HealthInfo = HealthInfo(bloodSugar: -1, bodyWeight: -1, systolic: -1, diastolic: -1, symptoms: "")
        let h5: HealthInfo = HealthInfo(bloodSugar: -1, bodyWeight: -1, systolic: -1, diastolic: -1, symptoms: "")
        let h6: HealthInfo = HealthInfo(bloodSugar: -1, bodyWeight: -1, systolic: -1, diastolic: -1, symptoms: "")
        let h7: HealthInfo = HealthInfo(bloodSugar: -1, bodyWeight: -1, systolic: -1, diastolic: -1, symptoms: "")
        healthTracker.append(h1)
        healthTracker.append(h2)
        healthTracker.append(h3)
        healthTracker.append(h4)
        healthTracker.append(h5)
        healthTracker.append(h6)
        healthTracker.append(h7)
    }
    
    func isFull() -> Bool
    {
        for i in 0...(healthTracker.count-1)
        {
            if healthTracker[i].bloodSugar == -1
            {
                return false
            }
        }
        
        return true;
    }
    
    func daysMissing() -> String
    {
        var missing: [Int] = []
        
        var daysMissing = ""
        
        for i in 0...(healthTracker.count-1)
        {
            if healthTracker[i].bloodSugar == -1
            {
                missing.append(i+1)
            }
        }
        
        
        if(missing.count == 0)
        {
            //do nothing
        }
        else{
            daysMissing.append("\(missing[0])")
            
            for i in 1...missing.count - 1
            {
                daysMissing.append(", \(missing[i])")
            }
        }
        
        return daysMissing
    }
    
    
    func atRisk() -> (Bool, Bool, Bool)
    {
        return (gainingWeight(), highBloodSugar(), highBloodPressure())
    }
    
    
    func gainingWeight() -> Bool
    {
        var lastFour: Float = 0.0
        var firstThree: Float = 0.0
        
        for i in 0...2
        {
            firstThree = firstThree + (healthTracker[i].bodyWeight)!
        }
        for i in 3...6
        {
            lastFour = lastFour + (healthTracker[i].bodyWeight)!
        }
        
        lastFour = lastFour / 4
        firstThree = firstThree / 3
        
        return lastFour > firstThree
    }
    
    func highBloodSugar() -> Bool
    {
        let change:Float = (healthTracker[6].bloodSugar)! / (healthTracker[5].bloodSugar)!
        
        return change >= 1.1
    }
    
    func highBloodPressure() -> Bool
    {
        let bp1 = Float((healthTracker[6].systolic)!) / Float((healthTracker[6].diastolic)!)
        let bp2 = Float((healthTracker[5].systolic)!) / Float((healthTracker[5].diastolic)!)
        
        let change:Float = bp1 / bp2
        
        return change >= 1.1
    }
    
}
