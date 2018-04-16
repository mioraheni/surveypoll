//
//  Prediction.swift
//  Meteo
//
//  Created by Henintsoa Miora on 29/01/2018.
//  Copyright © 2018 Henintsoa Miora. All rights reserved.
//

import UIKit

class Prediction: NSObject {
    var temp = 0.0 // En celsius
    var count = 1
    var risqueNeige = ""
}

//class Semaine
//{
//    var jour : Date
//
//}

class MeteoDB
{
    var rawDatas = [Date : Prediction]()
    
    var outPut = [ ( key : Date, value : Prediction ) ]()
    
    func compute()
    {
        outPut.removeAll()
        
        var out = [ Date : Prediction ]()
        
        for element in rawDatas
        {
            let calendar = Calendar.current
            
            var components = DateComponents()
            components.day = calendar.component(.day, from: element.key)
            components.month = calendar.component(.month, from: element.key)
            components.year = calendar.component(.year, from: element.key)
            
//            Version 1
            components.hour = calendar.component(.hour, from: element.key) < 12 ? 0 : 12
            
//            Version 2
//            if (calendar.component(.hour, from: element.timestamp) < 12)
//            {
//                components.hour = 0
//            }
//            else
//            {
//                components.hour = 12
//            }
            
            if let dayDate = calendar.date(from: components)
            {
                if let day = out[dayDate]
                {
                    //print("Add temp for date \(dayDate)")
                    day.temp += element.value.temp
                    day.count += 1
                }else
                {
                    //print("create entry for date \(dayDate)")
                    out[dayDate] = element.value
                }
            }
        }
        
        for entry in out {
            entry.value.temp /= Double(entry.value.count)
        }
        
        outPut = out.sorted { ( valueA, valueB) -> Bool in
            return valueA.key < valueB.key // classement par date
//            /* OU */ return elementA.temp < elementB.temp // classement par temperature
       }
    }
    /*
    func compute(){
        
    }
    
    var journees = ...
    */
}
