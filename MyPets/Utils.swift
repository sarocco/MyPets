//
//  Utils.swift
//  MyPets
//
//  Created by Carolina Rocco on 24/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit

 class Utils {
    
    static func addLostPet (pet:Pet) -> Array<Pet> {
        var pets: [Pet] = []
        pets.append(pet)
        return pets
    }
}
