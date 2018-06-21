//
//  PetViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit

class PetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petDataTable: UITableView!
    
    var pet: Pet?
    
    override func viewDidLoad() {
        
        petDataTable.delegate = self
        petDataTable.dataSource = self
        
        if let pet = pet {
            petName.text = pet.name
            petImage.image = pet.petPicture
        }
        super.viewDidLoad()

    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petDataTable.dequeueReusableCell(withIdentifier: "petInfoCell", for:indexPath) as? InfoPetTableViewCell
        return cell!
    }
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
