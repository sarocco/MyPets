//
//  AddPetViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 14/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseStorageUI
import Firebase
import FirebaseAuth

class AddPetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var textPetName: UITextField!
    @IBOutlet weak var textConactNumber: UITextField!
    @IBOutlet weak var textSex: UITextField!
    @IBOutlet weak var checkNac: UIDatePicker!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIButton!
    
    //Variables
    var message:String = ""
    var selectedImage: UIImage?
    var pet: Pet!
    var delegate: MyPetsViewControllerDelegate?

    //create an instance or Storage and reference
    var imageReference: StorageReference {
        return Storage.storage().reference()
    }

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
        if pet == nil{
        if let name = textPetName?.text,let conactNumber = textConactNumber.text, let sex = textSex?.text, let date = checkNac?.date {
            doSave (name:name, contactNumber: conactNumber, sex:sex ,date:date)
            }
        } else {editData(pet: pet)}
    }
    
    override func viewDidLoad() {

        let radius = (imageView.frame.width) / 2
        imageView.layer.cornerRadius = radius
        imageView.clipsToBounds = true
        if let pet = pet {
            textPetName.text = pet.name
            textConactNumber.text = pet.contactNumber
            textSex.text = pet.sex
            checkNac.date = Utils.formatMyString(str: pet.dateOfBirth!)
            downloadImage(image: pet.petPicture)
            viewWillAppear(true)
        }
        self.hideKeyboard()

        super.viewDidLoad()
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        if let pet = pet {
            editData(pet: pet)
        }
    }*/

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            selectedImage = image
            imageView.setImage(image, for: UIControlState.normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func doSave(name:String, contactNumber:String, sex:String ,date:Date){
        if(name == ""){
            message = "Name is not valid"
        }else{
            if(contactNumber == ""){
                message = "Contact number not valid"
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
                                pet.petPicture = "\(UUID().uuidString).jpg"
                                self.uploadImage(image: image, name: pet.petPicture) // Firebase Storage
                            }
                            pet.name = name
                            pet.contactNumber = contactNumber
                            pet.dateOfBirth = Utils.formatMyDate(date: date)
                            pet.sex = sex
                            pet.owner = (Auth.auth().currentUser?.email)!
                            self.delegate?.didSavePet(pet: pet)
                            let dbref = Database.database().reference()
                            let key = dbref.child("Pets").childByAutoId().key
                            pet.id = key
                            dbref.child("Pets").child(key).setValue(pet.toJSON())
                            self.navigationController?.popViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        return
                        }
                    }
                }
            }
        }
        let alert = UIAlertController(title: "Mensaje", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func editData(pet:Pet){
        if(textPetName.text == ""){
            message = "Name is not valid"
        }else{
            if(textConactNumber.text == ""){
                message = "Contact number not valid"
            }else{
                if(textSex.text == ""){
                    message = "Sex is not valid"
                }else{
                    if !validateBirth(birthDate: checkNac.date){
                        message = "Please check your pet's birthday"
                    }else{
                        if (self.selectedImage == nil){
                            message = "Please load your pets photo"
                        }else{
                            let alert = UIAlertController(title: "Mensaje", message: "Pet succesfully saved", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
                                let pet = pet
                                if let image = self.selectedImage {
                                    pet.petPicture = "\(UUID().uuidString).jpg"
                                    self.uploadImage(image: image, name: pet.petPicture) // Firebase Storage
                                }
                                pet.name = self.textPetName.text!
                                pet.contactNumber = self.textConactNumber.text!
                                pet.dateOfBirth = Utils.formatMyDate(date: self.checkNac.date)
                                pet.sex = self.textSex.text!
                                //self.delegate?.didUpdatePet(pet: pet)
                                let dbref = Database.database().reference()
                                dbref.child("Pets").child(pet.id).setValue(pet.toJSON())
                                let vController = self.storyboard?.instantiateViewController(withIdentifier: "IdentifierMyPets") as? MyPetsViewController
                                //self.navigationController?.viewControllers.popLast()
                            
                                self.navigationController?.pushViewController(vController!, animated: true)
                                //self.navigationController?.popViewController(animated: true)
                            }))
                            self.present(alert, animated: true, completion: nil)
                            return
                        }
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
    
    //Save image in Firebase Storage
    func uploadImage(image: UIImage, name: String){
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
        let imageSRef = self.imageReference.child(name)
        let upload = imageSRef.putData(imageData, metadata: nil) { (metadata, error) in
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
        }
        upload.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        upload.resume()
    }
    
    //Download image from Firebase Storage
    func downloadImage(image: String){
        let downloadImageRef = imageReference.child(image)
        self.imageView.imageView?.sd_setImage(with: downloadImageRef, placeholderImage: #imageLiteral(resourceName: "loadPhoto"))
    }
    
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


