//
//  MyPetsViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 14/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import GoogleSignIn
import FirebaseStorageUI
import ObjectMapper

class MyPetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MyPetsViewControllerDelegate, GIDSignInUIDelegate {

    //Outlets
    @IBOutlet weak var petsTable: UITableView!
    @IBOutlet weak var addPetsButton: UIButton!
    
    //Variables
    var pets:[Pet] = []
    var refPets: DatabaseReference!
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    //Actions
    @IBAction func goToAddPet(_ sender: Any) {
        performSegue(withIdentifier: "segueToAddPet", sender: self)
    }
    @IBAction func logOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petsTable.delegate = self
        petsTable.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refPets = Database.database().reference().child("Pets")
        refPets.observeSingleEvent(of: .value) { (snapshot) in
            if let values = snapshot.value as? [String: Any] {
                self.pets = []
                for (_ , value) in values {
                    if let newValue = Mapper<Pet>().map(JSONObject:value){
                        self.pets.append(newValue)
                    }
                }
                self.petsTable.reloadData()
            }
        }
    }
    
    func didSavePet(pet: Pet) {
        pets.append(pet)
        petsTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petsTable.dequeueReusableCell(withIdentifier: "petCell", for:indexPath) as? PetTableViewCell
        
        // Access to each Pet and displays the data of each one
        let pet = pets[indexPath.row]
        cell?.petName.text = pet.name
        let downloadImageRef = imageReference.child(pet.petPicture)
        cell?.petPicture.sd_setImage(with: downloadImageRef, placeholderImage: #imageLiteral(resourceName: "dog"))
        cell?.petPicture.clipsToBounds = true
        let radius = (cell?.petPicture.frame.width)! / 2
        cell?.petPicture.layer.cornerRadius = radius
        cell?.petPicture.layer.masksToBounds = true
        return cell!
    }
    
    //return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    //Set the height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //Send the information of the pet you select to the next controller: MatchViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pet = pets[indexPath.row]
        let vController = storyboard?.instantiateViewController(withIdentifier: "idPetViewController") as? PetViewController
        self.navigationController?.pushViewController(vController!, animated: true)
        vController?.pet = pet
    }
    
    //Deslect the selected row when go back
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.petsTable.indexPathForSelectedRow{
            self.petsTable.deselectRow(at: index, animated: true)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToAddPet" {
            let vController = segue.destination as! AddPetViewController
            vController.delegate = self
        }
    }
}

protocol MyPetsViewControllerDelegate {
    func didSavePet(pet : Pet)
}
