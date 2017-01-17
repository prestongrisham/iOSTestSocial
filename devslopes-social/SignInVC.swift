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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
        })
    }

}

