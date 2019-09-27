//
//  SignUpViewController.swift
//  DevLibs Build Week 2
//
//  Created by Ciara Beitel and Marc Jacques on 9/27/19.
//  Copyright © 2019 Ciara Beitel and Marc Jacques. All rights reserved.
//

import UIKit

enum LoginType {
    case signUp
    case logIn
}

class SignUpViewController: UIViewController {
    @IBOutlet weak var signUpOrLogInLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpOrLogInButton: UIButton!
    @IBOutlet weak var loginSignUpText: UILabel!
    @IBOutlet weak var changeLoginSignUp: UIButton!
    
    var apiController = APIController()
    var loginType = LoginType.signUp
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty,
            !password.isEmpty else { return }
        
        let user = User(username: username, password: password)
        
        if loginType == .signUp {
            apiController.signUp(with: user, completion: { (error) in
                if let error = error {
                    NSLog("Error occurred during sign up: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sign Up Not Successful", message: "Please try again", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Sign Up Successful", message: "Now please sign in", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true) {
                            self.changeUI()
                        }
                    }
                }
            })
        } else if loginType == .logIn {
            apiController.login(with: user, completion: { (error) in
                if let error = error {
                    NSLog("Error occurred during login: \(error)")
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "DashboardSegue", sender: self)
                    }
                }
            })
        }
    }
    
    func changeUI() {
        if self.loginType == .logIn {
            self.loginType = .signUp
            self.signUpOrLogInLabel.text = "Sign Up"
            self.signUpOrLogInButton.setTitle("Sign Up", for: .normal)
            self.loginSignUpText.text = "Already have an account?"
            self.changeLoginSignUp.setTitle("Log in", for: .normal)
        } else {
            self.loginType = .logIn
            self.signUpOrLogInLabel.text = "Log In"
            self.signUpOrLogInButton.setTitle("Log In", for: .normal)
            self.loginSignUpText.text = "Need to create an account?"
            self.changeLoginSignUp.setTitle("Sign Up", for: .normal)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        changeUI()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
}
