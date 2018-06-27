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

class AddPetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
    
    //Database Reference
    //var ref: DatabaseReference!
    var refPets: DatabaseReference!
    
    //create an instance or Storage and reference
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
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
        //addPet()
        if let name = textPetName?.text,let conactNumber = textConactNumber.text, let sex = textSex?.text, let date = checkNac?.date{
            doSave (name:name, contactNumber: conactNumber, sex:sex ,date:date)
        }
    }
    
    override func viewDidLoad() {
        if let pet = pet {
            textPetName.text = pet.name
            textConactNumber.text = pet.contactNumber
            textSex.text = pet.sex
            checkNac.date = pet.dateOfBirth!
             let radius = (imageView.frame.width) / 2
            imageView.layer.cornerRadius = radius
            imageView.clipsToBounds = true
            
            //downloadImage() //Download image from firebase storage
            imageView.setImage(pet.petPicture, for:[])
            
            //ref = Database.database().reference()
            refPets = Database.database().reference().child("Pet")
            //ref.child("Pets").child("Pet").child("Name").setValue("Holaaa")
        }
        super.viewDidLoad()
    }

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
                                pet.petPicture = image
                                self.uploadImage(image: image) // Firebase Storage
                            }
                            pet.name = name
                            pet.contactNumber = contactNumber
                            pet.dateOfBirth = date
                            pet.sex = sex
                            self.delegate?.didSavePet(pet: pet)
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
    
    func validateBirth(birthDate: Date) -> Bool{
        var isValid: Bool = true
        
        let minimumDate: Date = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        if birthDate >= minimumDate {
            isValid = false
        }
        return isValid
    }
    
    // Add pet in firebase databade
    //----NOT WORKING-----
    func addPet(){
        let key = refPets.childByAutoId().key
        let pet = [ "id": key,
                "Name": textPetName.text! as String,
                   "DateOfBirth" : checkNac.date.description,
                   "Sex": textSex.text! as String,
                   "ContactNumber": textConactNumber.text! as String
        ]
        refPets.child(key).setValue(pet)
    }
    
    //Save image in Firebase Storage
    //----NOT WORKING-----
    func uploadImage(image: UIImage){
        guard let imageData = UIImageJPEGRepresentation(image, 1) else {return}
        let imageSRef = self.imageReference.child(image.description)
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
    func downloadImage(){
        let downloadImageRef = imageReference.child(pet.petPicture.description)
        let downloadTask = downloadImageRef.getData(maxSize: 1024*1024*12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                self.imageView.setImage(image, for: .normal)
            }
            print(error ?? "NO ERROR")
        }
        downloadTask.observe(.progress){(snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        downloadTask.resume()
    }
}


