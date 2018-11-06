//
//  ViewController.swift
//  FirebaseAuth Example
//
//  Created by omrobbie on 06/11/18.
//  Copyright © 2018 omrobbie. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit

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
            
            if let uid = result?.user.uid {
                print("uid: \(uid)")
                self.txtSignIn.text = uid
            }
        }
    }
    
    @IBAction func btnSignInWithEmail(_ sender: Any) {
        let email = txtEmail.text!
        let password = txtPassword.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error: Sign in with email failed! \(error.localizedDescription)")
                return
            }
            
            if let uid = result?.user.uid {
                print("uid: \(uid)")
                self.txtSignIn.text = uid
            }
        }
    }
    
    @IBAction func btnSignInWithFacebook(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if let error = error {
                print("Error: Sign in with facebook failed! \(error.localizedDescription)")
                return
            }
            
            if result!.grantedPermissions != nil {
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                
                Auth.auth().signInAndRetrieveData(with: credential) { (result, error) in
                    if let error = error {
                        print("Error: Sign in and retrieve data facebook failed! \(error.localizedDescription)")
                        return
                    }
                    
                    if let uid = result?.user.uid {
                        print("uid: \(uid)")
                        self.txtSignIn.text = uid
                    }
                }
            }
        }
    }
    
    @IBAction func btnSignOut(_ sender: Any) {
        if Auth.auth().currentUser?.isAnonymous ?? false {
            Auth.auth().currentUser?.delete(completion: { (error) in
                if let error = error {
                    print("Error: Delete current user failed! \(error.localizedDescription)")
                    return
                }
            })
        }
        
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
