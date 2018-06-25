//
//  AddPetViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 14/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit

class AddPetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //Outlets
    @IBOutlet weak var textPetName: UITextField!
    @IBOutlet weak var textSex: UITextField!
    @IBOutlet weak var checkNac: UIDatePicker!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIButton!
    
    //Variables
    var message:String = ""
    var selectedImage: UIImage?
    var pet: Pet!
    var delegate: MyPetsViewControllerDelegate?

    //Actions
    @IBAction func importImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true)
    }

    @IBAction func bottonSave(_ sender: Any) {
        if let name = textPetName?.text, let sex = textSex?.text, let date = checkNac?.date{
            doSave (name:name, sex:sex ,date:date)
        }
    }
    
    override func viewDidLoad() {
        if let pet = pet {
            textPetName.text = pet.name
            textSex.text = pet.sex
            checkNac.date = pet.age!
            /* ------NOT WORKING ------- FIXME
             let radius = (imageView.frame.width) / 2
            imageView.layer.cornerRadius = radius
            imageView.clipsToBounds = true*/
            imageView.imageView?.image = pet.petPicture
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            selectedImage = image
            imageView.setImage(image, for: UIControlState.normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func doSave(name:String,sex:String ,date:Date){
        if(name == ""){
            message = "Name is not valid"
        }else{
            if(sex == ""){
                message = "Sex is not valid"
            }else{
                if !validateBirth(birthDate: date){
                    message = "Please check your pet's birthday"
                }else{
                    if (self.selectedImage == nil){
                        message = "Please load your pets photo"
                    }else{
                    let alert = UIAlertController(title: "Mensaje", message: "Pet succesfully saved", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
                        let pet = Pet()
                        if let image = self.selectedImage {
                            pet.petPicture = image
                        }
                        pet.name = name
                        pet.age = date
                        pet.sex = sex
                        //pet.petPicture = 
                        self.delegate?.didSavePet(pet: pet)
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    return
                    }
                }
            }
        }
        let alert = UIAlertController(title: "Mensaje", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func validateBirth(birthDate: Date) -> Bool{
        var isValid: Bool = true
        
        let minimumDate: Date = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        if birthDate >= minimumDate {
            isValid = false
        }
        return isValid
    }
    
}


