//
//  SignInVC.swift
//  devslopes-social
//
//  Created by Preston Grisham on 1/13/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    
    @IBOutlet weak var emailTextField: LoginTextFields!
    @IBOutlet weak var passwordTextField: LoginTextFields!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let userID = KeychainWrapper.standard.string(forKey: "uid") {
            print("CPG: User ID is: \(userID)")
            performSegue(withIdentifier: "showFeedVC", sender: nil)
        }
        
    }

    @IBAction func signInButtonPressed(_ sender: Any) {
        
        if let email = emailTextField.text , let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    //User Signed In
                    if let user = user {
                       self.completeSignIn(id: user.uid)
                    }
                    
                    print("CPG: User authenticated with email and password")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error == nil {
                            print("CPG: User created with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        } else if FIRAuthErrorCode(rawValue: error!._code) == .errorCodeEmailAlreadyInUse {
                            print("CPG: Email Address Already in Use")
                            // CREATE ALERT FOR THIS ERROR
                        }
                        else {
                            print("CPG: Error creating user: \(error)")
                        }
                    })
                }
            })
        } else {
            print("Need to fill out both fields")
            //CREATE ALERT HERE FOR USERS
        }
        
    }
    
    
    @IBAction func facebookButtonTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print("CPG: Facebook Login error: \(error)")
            }
            else if result?.isCancelled == true {
                print("CPG: User cancelled Facebook authentication")
            }
            else {
                print("CPG: Sucessfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                print("CPG: Facebook Credential: \(credential)")
                self.firebaseAuth(credential)
                
            }
        }
        
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) {
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("CPG: Firebase authentication error: \(error)")
            } else {
                print("CPG: Sucessfully authenticated with Firebase")
                if let user = user {
                    self.completeSignIn(id: user.uid)
                }
                
            }
        })
    }
    
    func completeSignIn(id: String) {
        KeychainWrapper.standard.set(id, forKey: "uid")
        performSegue(withIdentifier: "showFeedVC", sender: nil)
    }

}

