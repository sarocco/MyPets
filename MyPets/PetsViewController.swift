//
//  PetsViewController.swift
//  MyPetsTests
//
//  Created by Carolina Rocco on 7/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit

class PetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addPet: UIButton!
    @IBOutlet weak var petsTable: UITableView!
    
    var pets:[Pet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petsTable.delegate = self
        petsTable.dataSource = self
        petsTable.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = petsTable.dequeueReusableCell(withIdentifier: "petCell", for:indexPath) as? PetTableViewCell
        
        // Access to each Match and displays the data of each match in one row of the table
        let pet = pets[indexPath.row]
        cell?.petName.text = pet.name
        cell?.petPicture.image = UIImage(named: pet.petPicture)
        return cell!
    }
    
    //return the number of rows in a given section of a table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    //Set the height of the row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    //Send the information of the pet you select to the next controller: MatchViewController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pet = pets[indexPath.row]
        let vController = storyboard?.instantiateViewController(withIdentifier: "idPetViewController") as? PetViewController
        self.navigationController?.pushViewController(vController!, animated: true)
        vController?.pet = pet
    }
    
    //Deslect the selected row when go back
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.petsTable.indexPathForSelectedRow{
            self.petsTable.deselectRow(at: index, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
