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
    
    func loadArticle() {
        if let url = articleURL {
            let request = URLRequest(url: url)
            webView.load(request)
            loadingIndicator.startAnimating()
            loadingIndicator.isHidden = false
        }
    }
    
}

extension NewsDetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Delay hiding the loading indicator for 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.isHidden = true
        }
    }
}
