//
//  FeedVC.swift
//  devslopes-social
//
//  Created by Preston Grisham on 1/17/17.
//  Copyright © 2017 Preston Grisham. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func logOutPressed(_ sender: UIButton) {
        
        //let user = FIRAuth.auth()?.currentUser
        KeychainWrapper.standard.removeObject(forKey: "uid")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "showSignInVC", sender: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedTableViewCell
        
        return cell
        
    }
}
