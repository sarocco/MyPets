//
//  Pet.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class Pet {
    
    var location: CLLocationCoordinate2D?
    var name = ""
    var petPicture = UIImage()
    var sex = ""
    var age: Date?
    var vaccine: Vaccine?
    var contactNumber: String?
    
    init(){}

    init (name: String, sex:String, petPicture: UIImage) {
        self.name = name
        self.sex = sex
        self.petPicture = petPicture
    }
    
    init (name: String, sex:String, petPicture: UIImage, contactNumber:String, location:CLLocationCoordinate2D) {
        self.name = name
        self.sex = sex
        self.petPicture = petPicture
        self.contactNumber = contactNumber
        self.location = location
    }
    
    init (name: String, petPicture: UIImage, sex: String, age: Date, vaccine: Vaccine) {
        self.name = name
        self.petPicture = petPicture
        self.sex = sex
        self.age = age
        self.vaccine = vaccine
    }
    
}
