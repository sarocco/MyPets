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

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    public func logout() {
    GIDSignIn.sharedInstance().signOut()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
}



