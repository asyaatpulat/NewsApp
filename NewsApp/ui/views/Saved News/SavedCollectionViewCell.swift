//
//  SavedCollectionViewCell.swift
//  NewsApp
//
//  Created by Asya Atpulat on 14.09.2023.
//

import UIKit

class SavedCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: SavedCollectionViewCell.self)

    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
}
