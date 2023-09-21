//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Asya Atpulat on 10.09.2023.
//

import UIKit

protocol NewsCellDelegate: AnyObject {
    func saveButtonClicked(title: String, source: String, image: String)
}

class NewsCell: UICollectionViewCell {
    weak var delegate: NewsCellDelegate?
    var article: Article?
    var isBookmarked = false
    
    static let identifier = String(describing: NewsCell.self)
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func BtnClicked(_ sender: Any) {
        isBookmarked.toggle() // Toggle the state
        let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
        let image = UIImage(systemName: imageName)
        detailBtn.setImage(image, for: .normal)
        delegate?.saveButtonClicked(title: titleLabel.text ?? "", source: sourceLabel.text ?? "", image: article?.urlToImage ?? "")
    }
}
