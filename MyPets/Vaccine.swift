//
//  Vaccine.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

class Vaccine {
    var vaccineName: String
    var vaccinationDate: String?
    var nextDose: String?
    
    init (vaccineName: String , vaccinationDate: String, nextDose: String) {
        self.vaccineName = vaccineName
        self.vaccinationDate = vaccinationDate
        self.nextDose = nextDose
    }
}
