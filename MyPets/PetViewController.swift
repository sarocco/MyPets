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
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var notes: UITextView!
    @IBOutlet weak var editLabel: UIButton!
    @IBOutlet weak var reportLostLabel: UIButton!
    
    //Variables
    var pet: Pet?
    var locationManager = CLLocationManager()
    
    //Actions
    @IBAction func editPet(_ sender: Any) {
        performSegue(withIdentifier: "editId", sender: self)
    }
    
    @IBAction func reportLost(_ sender: Any) {
        determineMyCurrentLocation()
        performSegue(withIdentifier: "reportLostId", sender: self)
    }
    
    override func viewDidLoad() {
    
        if let pet = pet {
            petName.text = pet.name
            petImage.image = pet.petPicture
            let radius = (petImage.frame.width) / 2
            petImage.layer.cornerRadius = radius
            petImage.clipsToBounds = true
            birthday.text = pet.age?.description
            sex.text = pet.sex
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
    
}
