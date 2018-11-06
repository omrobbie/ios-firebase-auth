//
//  ViewController.swift
//  FirebaseAuth Example
//
//  Created by omrobbie on 06/11/18.
//  Copyright © 2018 omrobbie. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtSignIn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func btnSignInAnonymously(_ sender: Any) {
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error {
                print("Error: Sign in anonymously failed! \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else {return}
            
            print("uid: \(uid)")
            self.txtSignIn.text = uid
        }
    }
}
