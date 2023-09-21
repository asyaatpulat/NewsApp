//
//  SavedViewModel.swift
//  NewsApp
//
//  Created by Asya Atpulat on 21.09.2023.
//


import UIKit
import CoreData

class SavedViewModel {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var news: [News] = []
    
    func loadItems(completion: @escaping () -> Void) {
        let request: NSFetchRequest<News> = News.fetchRequest()
        do {
            news = try context.fetch(request)
            completion()
        } catch {
            print("Error fetching data from context (error)")
        }
    }
    
}
