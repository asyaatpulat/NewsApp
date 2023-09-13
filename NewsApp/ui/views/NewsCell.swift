//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Asya Atpulat on 10.09.2023.
//

import UIKit

class NewsCell: UICollectionViewCell {
    static let identifier = String(describing: NewsCell.self)
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
}
