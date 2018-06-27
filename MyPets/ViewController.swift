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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        GIDSignIn.sharedInstance().uiDelegate = self
        activityIndicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



