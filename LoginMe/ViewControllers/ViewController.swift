//
//  ViewController.swift
//  LoginMe
//
//  Created by Chitralekha Yellewar on 11/09/20.
//  Copyright © 2020 Chitralekha Yellewar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }

    func setUpElements() {
        Utilities.styleFilledButton(signupButton)
        Utilities.styleHollowButton(loginButton)

    }

}

