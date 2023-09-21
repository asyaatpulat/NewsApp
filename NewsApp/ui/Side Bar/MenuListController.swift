//
//  MenuListController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 15.09.2023.
//


import UIKit

protocol MenuListDelegate: AnyObject {
    func didSelectCategory(_ category: String)
}

class MenuListController: UITableViewController {
    var categories = ["Business","Entertainment","General","Health","Science","Sports","Technology"]
    weak var delegate: MenuListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         tableView.deselectRow(at: indexPath, animated: true)
         let selectedCategory = categories[indexPath.row]
         delegate?.didSelectCategory(selectedCategory)
     }
}
