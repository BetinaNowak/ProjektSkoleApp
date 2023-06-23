//
//  LoginViewController.swift
//  App Testing
//
//  Created by mediastyle on 08/06/2023.
//

import Foundation
import UIKit

class LoginViewController: UIViewController{
    let defaults = UserDefaults.standard
    let brugernavn = UIDevice.current.identifierForVendor!.uuidString
    
    @IBOutlet weak var fornavnField: UITextField!
    
    @IBAction func signUp(_ sender: Any) {
        
        print("empty")
        //print(defaults.string(forKey: "brugernavn") as Any)

        // if not, add user to the db
        var userArray = [String:Any]()
        userArray = [
            String("brugernavn"): String(brugernavn),
            String("fornavn"): String(fornavnField.text!),

        ]
        
        //NetworkServiceUsersPost.callPost(url: URL(string: "http://test-postnord.dk.linux21.curanetserver.dk/api-post-bruger.php")!, params: userArray)
        
        //print(currentUserBrugernavn!)
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "VelkommenVC") as! VelkommenViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
        
    override func viewDidAppear(_ animated: Bool) {
        if(defaults.string(forKey: "brugernavn") != nil)  {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavID") as! PostsViewController2
            self.navigationController?.pushViewController(nextViewController, animated: true)


        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        UserDefaults.standard.removeObject(forKey: "brugernavn")
        UserDefaults.standard.removeObject(forKey: "fornavn")

        // read the identifier for vendor
        //print(UIDevice.current.identifierForVendor!.uuidString)
        // check if we have the user data saved locally
        let currentUserBrugernavn = defaults.string(forKey: "brugernavn")
        //print(currentUserBrugernavn!)
        if(currentUserBrugernavn == nil){
            // if not
            // connect to the db and see if we have a user for that identifier
            NetworkServiceSingleUser.sharedObj.getSingleUser(brugernavn: brugernavn) {
                (Users) in
                print(Users)
                if(!Users.isEmpty){
                    print(Users[0].fornavn!)
                    self.defaults.set(self.brugernavn, forKey: "brugernavn")
                    self.defaults.set(Users[0].fornavn!, forKey: "fornavn")
                    //let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeNavID") as! PostsViewController2
                    //self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
        }

    }
    
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
