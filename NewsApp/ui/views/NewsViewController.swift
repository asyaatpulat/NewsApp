//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 9.09.2023.
//

import UIKit

class NewsViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    var viewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        prepareSearchBar()
        viewModel.loadNews()
        viewModel.onSuccess = reloadCollectionView()
        viewModel.onError = showError()
        
    }
    func prepareCollectionView() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
    }
    func prepareSearchBar() {
        searchBar.delegate = self
    }
    func reloadCollectionView()->() -> (){
        return {
            DispatchQueue.main.async {
            self.newsCollectionView.reloadData()
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

}
extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText )
    }
}
extension NewsViewController: UICollectionViewDelegateFlowLayout , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.identifier, for: indexPath) as! NewsCell
        cell.titleLabel?.text = viewModel.cellForRow(at: indexPath)?.title
        cell.titleLabel?.numberOfLines = 5
        cell.titleLabel?.lineBreakMode = .byTruncatingTail
        cell.sourceLabel.text = viewModel.cellForRow(at: indexPath)?.source?.name
        cell.newsImageView.downloaded(from: viewModel.cellForRow(at: indexPath)?.urlToImage ?? "")
        cell.backgroundColor? = .cyan
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 40) / 2, height: collectionView.bounds.size.height / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
 /*final class NewsViewModel {
  var onSuccess: (() -> ())?
  var onError: ((_ errorStr: String) -> ())?
  
  var articles: [Article]?
  
  func loadNews() {
      let resource = Resource<NewsResponse>(url: .country(country: "us"))
      NetworkManager.shared.fetchNews(resource: resource) { result in
          switch result {
          case .success(let success):
              self.articles = success.articles
              self.onSuccess?()

          case .failure(let failure):
              self.onError?(failure.localizedDescription)
          }
      }
  }
  
  func cellForRow(at indexPath: IndexPath) -> Article? {
      return articles?[indexPath.row]
  }
  
  func numberOfItems(in section: Int) -> Int {
      return articles?.count ?? 0
  }
}
  struct NewsResponse: Codable {
      let status: String?
      let totalResults: Int?
      let articles: [Article]?
  }

  struct Article: Codable {
      let source: Source?
      let author: String?
      let title, description: String?
      let url: String?
      let urlToImage: String?
      let publishedAt: Date?
      let content: String?
  }

  struct Source: Codable {
      let id: String?
      let name: String?
  }

  extension DateFormatter {
      static let iso8601Full: DateFormatter = {
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          return formatter
      }()
  }

  enum Path {
      case category(category: String, country: String)
      case country(country: String)
      
      var baseURL: String {
          return "https://newsapi.org/v2/top-headlines"
      }
      
      var apiKey: String {
          return "69ac707291b548c985685f955999a51e"
      }
      
      var path: URL {
          switch self {
          case .category(let category, let country):
              let urlString = "\(baseURL)?country=\(country)&category=\(category)&apiKey=\(apiKey)"
              return URL(string: urlString)!
          case .country(let country):
              let urlString = "\(baseURL)?country=\(country)&apiKey=\(apiKey)"
              return URL(string: urlString)!
          }
      }
  }


  struct Resource<T:Decodable> {
      var url: Path
  }


  final class NetworkManager {
      
      static let shared = NetworkManager()
          
      func fetchNews<T: Decodable>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> ()) {
          URLSession.shared.dataTask(with: resource.url.path) { data, response, error in
                  if let error = error {
                      completion(.failure(error))
                      return
                  }
                  guard let data = data else {
                      completion(.failure(NSError(domain: "Data Error", code: 0)))
                      return
                  }
                  do {
                      let decoder = JSONDecoder()
                      decoder.dateDecodingStrategy = .formatted(.iso8601Full) // Set date decoding strategy
                      let decodedData = try decoder.decode(T.self, from: data)
                      completion(.success(decodedData))
                  } catch {
                      completion(.failure(NSError(domain: "Decode Error", code: 0)))
                  }
              }.resume()
          }
      
  }

*/
