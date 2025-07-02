//
//  AuthViewController.swift
//  RamaswamyAditya-HW5
//
//  Created by Aditya Ramaswamy on 7/2/25.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    
    @IBOutlet weak var segController: UISegmentedControl!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmLabel: UILabel!
    @IBOutlet weak var confirmText: UITextField!
    @IBOutlet weak var statusText: UILabel!
    @IBOutlet weak var authButtonText: UIButton!
    
    let authSegue = "authID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segController.selectedSegmentIndex = 0
        authButtonText.setTitle("Log In", for: .normal)
        confirmLabel.isHidden = true
        confirmText.isHidden = true
        statusText.text = ""
        passwordText.isSecureTextEntry = true
        confirmText.isSecureTextEntry = true
        
        //listener to segue
        Auth.auth().addStateDidChangeListener() {
            (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: self.authSegue, sender: nil)
                self.userText.text = nil
                self.passwordText.text = nil
                self.confirmText.text = nil
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segController.selectedSegmentIndex = 0
        authButtonText.setTitle("Log In", for: .normal)
        confirmLabel.isHidden = true
        confirmText.isHidden = true
        statusText.text = ""
    }
    
    @IBAction func auth(_ sender: Any) {
        //Authenticate user creation
        if(segController.selectedSegmentIndex == 1) {
            guard confirmText.text == passwordText.text else {
                statusText.text = "Passwords do not match"
                return
            }
            Auth.auth().createUser(withEmail: userText.text!, password: passwordText.text!) {
                (authResult, error) in
                if let error = error as NSError? {
                    self.statusText.text = "\(error.localizedDescription)"
                } else {
                    self.statusText.text = ""
                    //Sign in automatically
                    Auth.auth().signIn(withEmail: self.userText.text!, password: self.passwordText.text!)
                }
            }
        }
        //Authenticate log in
        else {
            Auth.auth().signIn(withEmail: userText.text!, password: passwordText.text!) {
                (authResult, error) in
                if let error = error as NSError? {
                    self.statusText.text = "\(error.localizedDescription)"
                } else {
                    self.statusText.text = ""
                }
            }
        }
        
        
        
        
        
    }
    
    @IBAction func authChanged(_ sender: Any) {
        if(segController.selectedSegmentIndex == 0) {
            confirmLabel.isHidden = true
            confirmText.isHidden = true
            authButtonText.setTitle("Log In", for: .normal)
        } else {
            confirmLabel.isHidden = false
            confirmText.isHidden = false
            authButtonText.setTitle("Sign Up", for: .normal)
        }
        
        
        
    }
    

}
