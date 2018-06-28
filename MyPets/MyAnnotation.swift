//
//  MyAnnotation.swift
//  MyPets
//
//  Created by Carolina Rocco on 24/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation: NSObject, MKAnnotation {
    
    var pet: Pet
    
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: (pet.location?.latitude)!, longitude: (pet.location?.longitud)!)
        }
    }
    
    var title: String? {
        get {
            return pet.name
        }
    }
    
    var subtitle: String? {
        get {
            return pet.contactNumber
        }
    }
    
    
    init(pet: Pet) {
        self.pet = pet
        super.init()
    }
}

