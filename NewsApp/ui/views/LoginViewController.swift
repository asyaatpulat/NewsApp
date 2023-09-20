//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 7.09.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func register(_ sender: Any) {
        performSegue(withIdentifier: "toRegister", sender: self)
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                print("error")
            }else {
                let storyboard = UIStoryboard(name: "News", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
                    vc.userEmail = email
                    self.navigationController?.setViewControllers([vc], animated: true)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            
        }
    }
    
}
