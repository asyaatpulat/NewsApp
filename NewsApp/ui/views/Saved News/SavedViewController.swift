//
//  SavedViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 13.09.2023.
//

import UIKit
import CoreData

class SavedViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var news = [News]()
    
    
    @IBOutlet weak var savedCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
    }
    func prepareCollectionView() {
        savedCollectionView.delegate = self
        savedCollectionView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadItems()
    }
    func loadItems() {
            let request: NSFetchRequest<News> = News.fetchRequest()
            do {
                 news = try context.fetch(request)
            } catch {
                print("Error fetching data from context (error)")
            }
            savedCollectionView.reloadData()
        }

}

extension SavedViewController:UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedCollectionViewCell.identifier, for: indexPath) as! SavedCollectionViewCell
        cell.layer.borderColor = UIColor.darkGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10.0
        let selectedNew = news[indexPath.row]
        cell.titleLabel.text = selectedNew.title
        cell.sourceLabel.text = selectedNew.source
        cell.titleLabel?.lineBreakMode = .byTruncatingTail
        cell.titleLabel.numberOfLines = 4
        let imageURLString = selectedNew.image ?? ""
        cell.newsImageView.downloaded(from: URL(string: imageURLString)!)
        cell.newsImageView.contentMode = .scaleAspectFill
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 10 ), height: collectionView.bounds.size.height / 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}
