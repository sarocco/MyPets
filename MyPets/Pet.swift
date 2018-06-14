//
//  Pet.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import Foundation

class Pet {
    var name: String
    var petPicture: String
    var sex: String?
    var age: Int?
    var vaccine: Vaccine?

    init (name: String, petPicture: String) {
        self.name = name
        self.petPicture = petPicture
    }
    
    init (name: String, petPicture: String, sex: String, age: Int, vaccine: Vaccine) {
        self.name = name
        self.petPicture = petPicture
        self.sex = sex
        self.age = age
        self.vaccine = vaccine
    }
}
