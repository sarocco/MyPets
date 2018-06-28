//
//  LostPetViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 27/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorageUI
import ObjectMapper

class LostPetViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var lostDate: UILabel!
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var petSex: UILabel!
    
    //Variables
    var pet:Pet?
    //create an instance or Storage and reference
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    //Actions
    @IBAction func contactOwner(_ sender: Any) {
        if let url = URL(string:"tel://(pet.contactNumber)"){
            UIApplication.shared.open(url, options: [ : ],completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        if let pet = pet {
            petName.text = pet.name
            lostDate.text = pet.lastSeen
            petAge.text = Utils.getPetAge(dateOfBirth: pet.dateOfBirth!)
            petSex.text = pet.sex
            downloadImage()
            let radius = (petImage.frame.width) / 2
            petImage.layer.cornerRadius = radius
            petImage.clipsToBounds = true
        }
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Download image from Firebase Storage
    func downloadImage(){
        let downloadImageRef = imageReference.child((pet?.petPicture)!)
        self.petImage.sd_setImage(with: downloadImageRef, placeholderImage: #imageLiteral(resourceName: "dog"))
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
