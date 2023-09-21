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
    
    override func awakeFromNib() {
            super.awakeFromNib()
            configureCellAppearance()
    }

    private func configureCellAppearance() {
        layer.borderColor = UIColor(named: "appColor")?.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10.0
    }

    func configure(with news: News) {
        titleLabel.text = news.title
        sourceLabel.text = news.source
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.numberOfLines = 4
        let imageURLString = news.image ?? ""
        newsImageView.downloaded(from: URL(string: imageURLString)!)
        newsImageView.contentMode = .scaleAspectFill
    }
}
