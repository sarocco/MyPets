//
//  MapViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 14/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var lostPets:[Pet]?
    var button: UIButton!

    
    override func viewDidLoad() {
        if let lostPets = lostPets {
            for pet in lostPets {
                let annotation = MyAnnotation(pet: pet)
                //let annotation = MKPointAnnotation()
                //annotation.title = pet.name
                //annotation.subtitle = pet.contactNumber
                //annotation.coordinate = pet.location!
                mapView.addAnnotation(annotation)
            }
        }
        mapView.delegate = self
        super.viewDidLoad()
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MyAnnotation) {
            return nil
        }
        let reuseId = "id"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
            
            //set a button on at the right of the annotation
            button = UIButton(type: UIButtonType.detailDisclosure) as UIButton
            anView?.rightCalloutAccessoryView = button
            anView!.annotation = annotation
        }
        return anView
    }
    
   /* //Send the information of the atm to the next view conroller when the button of the annotation is pressed
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView{
            let an = view.annotation as! MyAnnotation
            let vController = storyboard?.instantiateViewController(withIdentifier: "reportLostId") as? PetViewController
            self.navigationController?.pushViewController(vController!, animated: true)
            vController?.pet = an.pet
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
