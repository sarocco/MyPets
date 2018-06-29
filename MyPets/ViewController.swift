//
//  ViewController.swift
//  MyPets
//
//  Created by Carolina Rocco on 2/6/18.
//  Copyright © 2018 Silvia Rocco. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    //Outlets
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        self.view.backgroundColor = UIColor(patternImage:UIImage (named:"bkgr")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



