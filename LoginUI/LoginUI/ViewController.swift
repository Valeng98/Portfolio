//
//  ViewController.swift
//  LoginUI
//
//  Created by Valentina Guarnizo on 3/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginOrRegister: UISegmentedControl!
    @IBOutlet weak var emailTxField: UITextField!
    @IBOutlet weak var confirmEmailTxField: UITextField!
    @IBOutlet weak var passwordTxField: UITextField!
    @IBOutlet weak var confEmailAnnotation: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var notificationLabel: UILabel!

    
    var loginMode = true
    var passwordHidden = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmEmailTxField.isHidden = true
        confEmailAnnotation.isHidden = true
        passwordTxField.isSecureTextEntry = true
        notificationLabel.isHidden = true
    }

    @IBAction func logout(_ sender: Any) {
    }
    @IBAction func forgotyourpassword(_ sender: Any) {
    }
    @IBAction func signInAction(_ sender: Any) {
        if loginMode{
            
            let email = emailTxField.text
            let pass = passwordTxField.text
            if email == "example@gmail.com" && pass == "Pass1234"{
                
                notificationLabel.isHidden = false
                notificationLabel.text = "Login Successeded"
                notificationLabel.backgroundColor = .clear
            }
            else {
                notificationLabel.isHidden = false
                notificationLabel.text = "Login Failed"
                notificationLabel.backgroundColor = .lightGray
            }
        }
        //register
        else {
            
            let email = emailTxField.text
            let confEmail = confirmEmailTxField.text
            let pass = passwordTxField.text
            
            if email == "" || confEmail == "" || pass == ""  {
                notificationLabel.isHidden = false
                notificationLabel.text = "All fields are necessary"
                notificationLabel.backgroundColor = .systemOrange
            }
            else {
                
            if email != confEmail {
                notificationLabel.isHidden = false
                notificationLabel.text = "The two emails don't match"
                notificationLabel.backgroundColor = .systemOrange
            }
            else{
                notificationLabel.isHidden = false
                notificationLabel.text = "Registered Successfully"
                notificationLabel.backgroundColor = .systemGreen
            }
        }
    }
        emailTxField.resignFirstResponder()
        passwordTxField.resignFirstResponder()
        confirmEmailTxField.resignFirstResponder()
        
        emailTxField.text = ""
        confirmEmailTxField.text = ""
        passwordTxField.text = ""
  }
    @IBAction func switchToLoginOrRegister(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            
            loginMode = true // login mode
            confirmEmailTxField.isHidden = true
            confEmailAnnotation.isHidden = true
            mainButton.setTitle("Login", for: UIControl.State.normal)
        }
        else {
            loginMode = false // register mode
            confirmEmailTxField.isHidden = false
            confEmailAnnotation.isHidden = false
            mainButton.setTitle("Register", for: UIControl.State.normal)
        }
    }
    @IBAction func revealPassword(_ sender: UIButton) {
        
        if passwordHidden{
            passwordHidden = false
            sender.setImage(UIImage(systemName: "eye.fill"), for: UIControl.State.normal)
        }
        else {
            passwordHidden = true
            sender.setImage(UIImage(systemName: "eye.slash.fill"), for: UIControl.State.normal)
        }
    }
}

