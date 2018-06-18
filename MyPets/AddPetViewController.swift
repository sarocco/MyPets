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
    @IBOutlet weak var checkCondition: UISwitch!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIButton!
    
    //Variables
    var message:String = ""
    var pet: Pet!

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
            let vController = storyboard?.instantiateViewController(withIdentifier: "IdentifierMyPets") as? MyPetsViewController
            self.navigationController?.pushViewController(vController!, animated: true)
            vController?.pet = pet
            //performSegue(withIdentifier: "segueToAddPet", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.setImage(image, for: UIControlState.normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    

    func doSave(name:String,sex:String ,date:Date){
    if(name == " "){
        message = "Name is not valid"
    }else{
        if(sex == " "){
            message = "Sex is not valid"
        }else{
            if (!checkCondition.isOn){
                message = "Acept terms and conditions, please"
            }else{
                if !validateBirth(birthDate: date){
                    message = "Confirm your birth day"
                }else{
                    self.activityIndicator.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute:{
                        self.activityIndicator.stopAnimating()
                        self.message = "Login succesfully"
                    }
                )}
            }
        }
    }
    
    let alert = UIAlertController(title: "Mensaje", message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
}
    
    func validateBirth(birthDate: Date) -> Bool{
        var isValid: Bool = true
        
        let minimumDate: Date = Calendar.current.date(byAdding: .year, value: -18, to: Date())!
        if birthDate > minimumDate {
            isValid = false
        }
        return isValid
        
    }
    
    func loadData(){
        pet.name = textPetName.text!
        pet.sex = textSex.text!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToAddPet" {
            let vController = segue.destination as! MyPetsViewController
            vController.pet = pet
        }
    }
}

