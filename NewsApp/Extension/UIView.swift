//
//  UIView.swift
//  NewsApp
//
//  Created by Asya Atpulat on 20.09.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
