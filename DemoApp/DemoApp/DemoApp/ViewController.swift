//
//  ViewController.swift
//  DemoApp
//
//  Created by Chandra Hasan on 04/06/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var mainLabel: UILabel!
    
    @IBOutlet var loginView: UIView!
    @IBOutlet var logUsername: UITextField!
    @IBOutlet var logPassword: UITextField!
    @IBOutlet var sliderButton: UISegmentedControl!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var registerView: UIView!
    @IBOutlet var regUsername: UITextField!
    @IBOutlet var regEmail: UITextField!
    @IBOutlet var regPassword: UITextField!
    @IBOutlet var regPhone: UITextField!
    
    @IBOutlet var registerButton: UIButton!
    
    let secScreen = SecondScreen()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerView.isHidden = true
    }

    @IBAction func segment_Control(_ sender: Any) {
        if sliderButton.selectedSegmentIndex == 0{
            loginView.isHidden = false
            registerView.isHidden = true
        }
        else{
            loginView.isHidden = true
            registerView.isHidden = false
        }
    }
    
    @IBAction func login(_ sender: Any) {
        print("Login Button Pressed")
        
        if logUsername.text != "" && logPassword.text != ""{
            
            print("DONE")
            
            logUsername.text = ""
            logPassword.text = ""
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let secVC = storyBoard.instantiateViewController(withIdentifier: "SecondScreen") as! SecondScreen
            secVC.modalPresentationStyle = .fullScreen
            self.present(secVC, animated: true)
        }
        else{
            mainLabel.text = "All fields are required"
            print("all fields are required")
        }
    }
    
    @IBAction func register(_ sender: Any) {
        print("Register Button Pressed")
        
        if regUsername.text != "" && regEmail.text != "" && regPhone.text != "" && regPassword.text != "" {
            
            print("DONE")
            logUsername.text = regEmail.text
            logPassword.text = regPassword.text
            
            
            
            // secScreen.nameLabel.text = regUsername.text!
            // secScreen.dataLabel.text = regEmail.text! + "\n" + regPhone.text!
            
            sliderButton.selectedSegmentIndex = 0
            registerView.isHidden = true
            loginView.isHidden = false
            
            
            regUsername.text = ""
            regEmail.text = ""
            regPhone.text = ""
            regPassword.text = ""
            
        }
        else{
            mainLabel.text = "All fields are required"
            print("all fields are required")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        logUsername.endEditing(true)
        logPassword.endEditing(true)
        regUsername.endEditing(true)
        regEmail.endEditing(true)
        regPhone.endEditing(true)
        regPassword.endEditing(true)
    }
    
}

