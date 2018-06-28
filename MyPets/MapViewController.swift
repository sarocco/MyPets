//
//  MapViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 14/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import ObjectMapper

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var lostPets:[Pet]?
    var button: UIButton!
    
    override func viewDidLoad() {
        mapView.delegate = self
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let dbref = Database.database().reference()
        dbref.child("Pets").queryOrdered(byChild: "Lost").queryEqual(toValue: true).observeSingleEvent(of: .value) { (snapshot) in
            if let values = snapshot.value as? [String: Any] {
                self.lostPets = []
                for (_ , value) in values {
                    if let newValue = Mapper<Pet>().map(JSONObject:value){
                        self.lostPets?.append(newValue)
                    }
                }
            }
            if let lostPets = self.lostPets {
                for pet in lostPets {
                        let annotation = MyAnnotation(pet: pet)
                        self.mapView.addAnnotation(annotation)
                    }
                }
            self.mapView.reloadInputViews()
        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MyAnnotation) {
            return nil
        }
        let anView = MKAnnotationView(annotation: annotation, reuseIdentifier: "reuseId")
        anView.image = UIImage(named:"bone")
        anView.canShowCallout = true
        button = UIButton(type: UIButtonType.detailDisclosure) as UIButton
        anView.rightCalloutAccessoryView = button
        anView.annotation = annotation
        return anView
    }
    
   //Send the information of the atm to the next view conroller when the button of the annotation is pressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            let an = view.annotation as! MyAnnotation
            let vController = storyboard?.instantiateViewController(withIdentifier: "reportLostId") as? LostPetViewController
            self.navigationController?.pushViewController(vController!, animated: true)
            vController?.pet = an.pet
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
