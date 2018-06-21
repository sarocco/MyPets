//
//  Pet.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import Foundation
import UIKit

class Pet {
    var name = ""
    var petPicture = UIImage()
    var sex = ""
    var age: Date?
    var vaccine: Vaccine?
    
    init(){}

    init (name: String, sex:String, petPicture: UIImage) {
        self.name = name
        self.sex = sex
        self.petPicture = petPicture
    }
    
    init (name: String, petPicture: UIImage, sex: String, age: Date, vaccine: Vaccine) {
        self.name = name
        self.petPicture = petPicture
        self.sex = sex
        self.age = age
        self.vaccine = vaccine
    }
}
