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
}
