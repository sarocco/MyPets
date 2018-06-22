//
//  PetViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit

class PetViewController: UIViewController {

    //Outlets
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var editLabel: UIButton!
    
    //Variables
    var pet: Pet?
    
    //Actions
    @IBAction func editPet(_ sender: Any) {
        performSegue(withIdentifier: "editId", sender: self)
    }
    
    override func viewDidLoad() {
        if let pet = pet {
            petName.text = pet.name
            petImage.image = pet.petPicture
            birthday.text = pet.age?.description
            sex.text = pet.sex
        }
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editId" {
            let vController = segue.destination as! AddPetViewController
            vController.pet = pet
        }
    }
    

}
