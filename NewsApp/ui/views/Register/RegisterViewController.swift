//
//  RegisterViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 7.09.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
    }

    @IBAction func signUp(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                let alertController = UIAlertController(title: "Error", message: "Use at least 6 digit password", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
                print("Error: \(e.localizedDescription)")
            }else {
                let storyboard = UIStoryboard(name: "News", bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController {
                    vc.userEmail = email
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    self.navigationController?.setViewControllers([vc], animated: true)
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            
        }
    }
}
