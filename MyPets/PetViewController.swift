//
//  PetViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import CoreLocation

class PetViewController: UIViewController, CLLocationManagerDelegate {

    //Outlets
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var contactNumberLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var dateOfBirth: UILabel!
    @IBOutlet weak var contactNumber: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var reportLostLabel: UIButton!
    
    //Variables
    var pet: Pet?
    var locationManager = CLLocationManager()
    
    //Actions
    @IBAction func editPet(_ sender: Any) {
        performSegue(withIdentifier: "editId", sender: self)
    }
    
    @IBAction func reportLost(_ sender: Any) {
        if (reportLostLabel.currentTitle == "Report Lost"){
        determineMyCurrentLocation()
        pet?.lost = true
        performSegue(withIdentifier: "reportLostId", sender: self)
        } else {
            pet?.lost = false
        }
    }
    
    override func viewDidLoad() {
    
        if let pet = pet {
            petName.text = pet.name
            petImage.image = pet.petPicture
            let radius = (petImage.frame.width) / 2
            petImage.layer.cornerRadius = radius
            petImage.clipsToBounds = true
            dateOfBirth.text = formatDate(date: pet.dateOfBirth!)
            contactNumber.text = pet.contactNumber
            sex.text = pet.sex
            if (pet.lost == false){
                reportLostLabel.setTitle("Report Lost", for: UIControlState.normal)
            } else {
                reportLostLabel.setTitle("Report Found", for: UIControlState.normal)            }
        }
        super.viewDidLoad()
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
            //pet?.location = locationManager.location?.coordinate
            pet?.location = CLLocationCoordinate2D(latitude: -34.886254, longitude: -56.149628)
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editId" {
            let vController = segue.destination as! AddPetViewController
            vController.pet = pet
        }
        if segue.identifier == "reportLostId" {
            let vController = segue.destination as! MapViewController
            var lostPets = Utils.addLostPet(pet:pet!)
            vController.lostPets = lostPets
        }
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
}
