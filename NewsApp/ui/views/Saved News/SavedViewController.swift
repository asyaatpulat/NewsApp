//
//  SavedViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 13.09.2023.
//

import UIKit
import CoreData

class SavedViewController: UIViewController {
    
    @IBOutlet weak var savedCollectionView: UICollectionView!
    private var viewModel = SavedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
    }
    
    func prepareCollectionView() {
        savedCollectionView.delegate = self
        savedCollectionView.dataSource = self
    }
    
    func loadItems() {
        viewModel.loadItems {
            DispatchQueue.main.async {
                self.savedCollectionView.reloadData()
            }
        }
    }
}

extension SavedViewController:UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedCollectionViewCell.identifier, for: indexPath) as! SavedCollectionViewCell
        cell.configure(with: viewModel.news[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.news.count
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
