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
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            self.txtSignIn.text = Auth.auth().currentUser?.uid
        }
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
    
    @IBAction func btnSignInWithEmail(_ sender: Any) {
        guard let email = txtEmail.text else {return}
        guard let password = txtPassword.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: Sign in with email failed! \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else {return}
            
            print("uid: \(uid)")
            self.txtSignIn.text = uid
        }
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error: Sign out failed! \(error.localizedDescription)")
            return
        }
        
        print("Sign out success!")
        self.txtSignIn.text = "Sign out success!"
    }
}
