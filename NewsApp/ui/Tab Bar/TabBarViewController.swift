//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 12.09.2023.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    var userEmail: String?
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 0
    }
    
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 0
    }
}
