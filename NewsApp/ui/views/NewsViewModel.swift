//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Asya Atpulat on 10.09.2023.
//

import Foundation

final class NewsViewModel {
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
