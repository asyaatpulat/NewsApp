//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 9.09.2023.
//

import UIKit
import SideMenu
import CoreData

class NewsViewController: UIViewController , MenuListDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    
    var menu : SideMenuNavigationController?
    
    var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSideMenu()
        prepareCollectionView()
        viewModel.loadNews()
        prepareSearchBar()
        viewModel.onSuccess = reloadCollectionView()
        viewModel.onError = showError()
        if let menuListController = menu?.viewControllers.first as? MenuListController {
                 menuListController.delegate = self
         }
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask ))
    }
    
    @IBAction func sideMenu(_ sender: Any) {
        if let menu = menu {
            print("Presenting Menu")
            present(menu, animated: true, completion: nil)
        }
    }
    
    func prepareSideMenu(){
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    func prepareCollectionView() {
        newsCollectionView?.delegate = self
        newsCollectionView?.dataSource = self
    }
    
    func prepareSearchBar() {
        searchBar?.delegate = self
    }
    
    func reloadCollectionView()->() -> (){
        return {
            DispatchQueue.main.async {
                self.newsCollectionView?.reloadData()
            }
        }
    }
    
    func showError() -> (_ errorStr: String) -> () {
        return { errorStr in
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Error!", message: errorStr, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }
        }
    }
    func didSelectCategory(_ category: String) {
        viewModel.category = category
        viewModel.loadNews()
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        viewModel.loadNews()
        print(searchText)
    }
}
extension NewsViewController: UICollectionViewDelegateFlowLayout , UICollectionViewDataSource, NewsCellDelegate{
    func saveButtonClicked(title: String, source: String, image: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let context = appDelegate.persistentContainer.viewContext

        if let entity = NSEntityDescription.entity(forEntityName: "News", in: context), let news = NSManagedObject(entity: entity, insertInto: context) as? NSManagedObject {
            news.setValue(title, forKey: "title")
            news.setValue(source, forKey: "source")
            news.setValue(image, forKey: "image")

            do {
                try context.save()
                print("Haber kaydedildi.")
            } catch {
                print("Haber kaydedilirken bir hata oluştu: \(error)")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.delegate = self
        if let article = viewModel.cellForRow(at: indexPath) {
            cell.layer.borderColor = UIColor.black.cgColor
            cell.titleLabel?.text = viewModel.cellForRow(at: indexPath)?.title
            cell.titleLabel?.lineBreakMode = .byTruncatingTail
            cell.titleLabel?.numberOfLines = 6
            cell.titleLabel?.font = .poppinsRegular(size: 18)
            cell.sourceLabel?.font = .poppinsRegular(size: 10)
            cell.dateLabel?.font = .poppinsThin(size: 2)
            cell.dateLabel?.text = viewModel.cellForRow(at: indexPath)?.publishedAt?.fullDateString()
            cell.sourceLabel.text = viewModel.cellForRow(at: indexPath)?.source?.name
            cell.newsImageView.downloaded(from: viewModel.cellForRow(at: indexPath)?.urlToImage ?? "")
            cell.article = article
            cell.newsImageView.contentMode = .scaleAspectFill
        }
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 10.0
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 40) / 2, height: collectionView.bounds.size.height / 2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          if let article = viewModel.cellForRow(at: indexPath), let articleURLString = article.url, let url = URL(string: articleURLString) {
              if let destinationVC = storyboard?.instantiateViewController(withIdentifier: "NewsDetailViewController") as? NewsDetailViewController {
                  destinationVC.articleURL = url
                  navigationController?.pushViewController(destinationVC, animated: true)
              }
          }
      }
}

extension Date {
    func fullDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: self)
    }
}

