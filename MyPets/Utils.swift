//
//  Utils.swift
//  MyPets
//
//  Created by Carolina Rocco on 24/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit

 class Utils {
    
    static func formatMyDate (date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func formatMyString (str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.date(from: str)!
    }
    
    static func getTodayDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.string(from: date)
        return (result)
    }
    
    static func getPetAge(dateOfBirth:String) -> String {
        let birth = formatMyString(str: dateOfBirth)
        let date = Date()
        let tod = formatMyDate(date: date)
        let today = formatMyString(str: tod)
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: birth, to: today)
        return (components.year?.description)!
    }
}
