//
//  LoginViewController.swift
//  LoginMe
//
//  Created by Chitralekha Yellewar on 11/09/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleHollowButton(loginButton)
    }
    
    func validateFields() -> String? {
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return Constants.Fields.Error
        } else {
            let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            if Utilities.isPasswordValid(cleanPassword) == false {
                return Constants.Password.Error
            }
        }
        return nil
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        if let error = validateFields() {
            showError(error)
        } else {
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil {
                    self.showError(error!.localizedDescription)
                }
                self.transitionToHome()
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
