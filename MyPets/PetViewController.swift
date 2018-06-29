//
//  PetViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseStorage
import FirebaseStorageUI
import FirebaseDatabase
import ObjectMapper

class PetViewController: UIViewController, CLLocationManagerDelegate {

    //Outlets
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var reportLostLabel: UIButton!
    
    //Variables
    var pet: Pet?
    var locationManager = CLLocationManager()
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }
    
    //Actions
    @IBAction func editPet(_ sender: Any) {
        performSegue(withIdentifier: "segueToEdit", sender: self)

    }
    
    @IBAction func reportLost(_ sender: Any) {
        if (reportLostLabel.currentTitle == "Report Lost"){
            determineMyCurrentLocation()
            let dbref = Database.database().reference()
            dbref.child("Pets").child((pet?.id)!).child("Location").setValue(pet?.location?.toJSON())
            dbref.child("Pets").child((pet?.id)!).child("Lost").setValue(true)
            pet?.lastSeen = Utils.getTodayDate()
            dbref.child("Pets").child((pet?.id)!).child("LastSeen").setValue(pet?.lastSeen)
            performSegue(withIdentifier: "reportLostId", sender: self)
        } else {
            let dbref = Database.database().reference()
            dbref.child("Pets").child((pet?.id)!).child("Lost").setValue(false)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewDidLoad() {
    
        if let pet = pet {
            petName.text = pet.name
            downloadImage()
            let radius = (petImage.frame.width) / 2
            petImage.layer.cornerRadius = radius
            petImage.clipsToBounds = true
            dateOfBirth.text = Utils.getPetAge(dateOfBirth: pet.dateOfBirth!)
            contactNumber.text = pet.contactNumber
            sex.text = pet.sex
            if (pet.lost == false){
                reportLostLabel.setTitle("Report Lost", for: UIControlState.normal)
            } else {
                reportLostLabel.setTitle("Report Found", for: UIControlState.normal)}
        }
        super.viewDidLoad()
    }
    
    func didUpdatePet(pet: Pet) {
        super.reloadInputViews()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        determineMyCurrentLocation()
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            //startUpdatingLocation()
            let lat = locationManager.location?.coordinate.latitude
            let lon = locationManager.location?.coordinate.longitude
            pet?.location = Location(lat: lat!, lon: lon!)
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        // manager.stopUpdatingLocation()
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEdit" {
            let vController = segue.destination as! AddPetViewController
            vController.pet = pet
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    //Download image from Firebase Storage
    func downloadImage(){
        let downloadImageRef = imageReference.child((pet?.petPicture)!)
        self.petImage.sd_setImage(with: downloadImageRef, placeholderImage: #imageLiteral(resourceName: "dog"))
    }
    
}

