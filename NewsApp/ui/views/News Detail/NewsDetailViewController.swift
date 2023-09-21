//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 9.09.2023.
//


import UIKit
import WebKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var articleURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadArticle()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadingIndicator.startAnimating()
        loadingIndicator.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        }
    }
    
    func loadArticle() {
        if let url = articleURL {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
