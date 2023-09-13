//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 12.09.2023.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.selectedIndex = 1
    }
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 1
    }
}
