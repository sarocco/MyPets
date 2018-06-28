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
import ObjectMapper

class Pet: Mappable{
    
    required init?(map: Map) {
    }
    
    var location: Location?
    var id = ""
    var name = ""
    var petPicture = ""
    var sex = ""
    var dateOfBirth: String?
    var contactNumber: String?
    var lost = false
    var owner = ""
    var lastSeen = ""
    
    init(){}

    init (id: String, name: String, sex:String, petPicture: String, lost:Bool, owner: String) {
        self.id = id
        self.name = name
        self.sex = sex
        self.petPicture = petPicture
        self.lost = lost
        self.owner = owner
    }
    
    init (name: String, sex:String, petPicture: String, contactNumber:String, location:Location, lost:Bool, lastSeen: String) {
        self.name = name
        self.sex = sex
        self.petPicture = petPicture
        self.contactNumber = contactNumber
        self.location = location
        self.lost = lost
        self.lastSeen = lastSeen
    }
    
    init (name: String, petPicture: String, sex: String, dateOfBirth: String, lost: Bool) {
        self.name = name
        self.petPicture = petPicture
        self.sex = sex
        self.dateOfBirth = dateOfBirth
        self.lost = lost
    }
    
    func mapping(map: Map) {
        id <- map["Id"]
        location <- map["Location"]
        name <- map["Name"]
        sex <- map["Sex"]
        dateOfBirth <- map["DateOfBirth"]
        lost <- map["Lost"]
        contactNumber <- map["ContactNumber"]
        petPicture <- map["PetPicture"]
        owner <- map ["Owner"]
        lastSeen <- map ["LastSeen"]
    }
    
}
