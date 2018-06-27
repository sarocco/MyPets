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
    var id: String?
    var name = ""
    var petPicture = UIImage()
    var sex = ""
    var dateOfBirth: Date?
    var contactNumber: String?
    var lost = false
    
    init(){}

    init (id: String?, name: String, sex:String, petPicture: UIImage, lost:Bool) {
        self.id = id
        self.name = name
        self.sex = sex
        self.petPicture = petPicture
        self.lost = lost
    }
    
    init (name: String, sex:String, petPicture: UIImage, contactNumber:String, location:CLLocationCoordinate2D, lost:Bool) {
        self.name = name
        self.sex = sex
        self.petPicture = petPicture
        self.contactNumber = contactNumber
        self.location = location
        self.lost = lost
    }
    
    init (name: String, petPicture: UIImage, sex: String, dateOfBirth: Date, lost: Bool) {
        self.name = name
        self.petPicture = petPicture
        self.sex = sex
        self.dateOfBirth = dateOfBirth
        self.lost = lost
    }
    
}
