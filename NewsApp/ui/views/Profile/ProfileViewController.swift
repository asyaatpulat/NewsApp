//
//  ProfileViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 13.09.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userEmail = UserDefaults.standard.string(forKey: "userEmail") {
            emailLabel.text = userEmail
        }
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        if #available(iOS 13.0, *){
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn {
                appDelegate?.overrideUserInterfaceStyle = .dark
                labelText.text = "Dark Mode"
            }
            else{
                appDelegate?.overrideUserInterfaceStyle = .light
                labelText.text = "Light Mode"
            }
        }
    }
}
