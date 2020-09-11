//
//  SignUpViewController.swift
//  LoginMe
//
//  Created by Chitralekha Yellewar on 11/09/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signupButton)
    }
    
    func validateFields() -> String? {
        //check all the fields are filled in
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return Constants.Fields.Error
        }
        
        // check if the password is secure
        let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPassword) == false {
            return Constants.Password.Error
        }
        
        return nil
    }
    
    @IBAction func signupTapped(_ sender: UIButton) {
        //validate the fields
        if let error = validateFields() {
            showError(error)
        } else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
        // create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError("Error Creating user")
                } else {
                    let firebaseDB = Firestore.firestore()
                    firebaseDB.collection("Users").addDocument(data: ["FirstName": firstName, "LastName" : lastName, "uid" : result!.user.uid ]) { (error) in
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                    }
                    // transition to home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: Constants.storyboard.HomeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }

}
