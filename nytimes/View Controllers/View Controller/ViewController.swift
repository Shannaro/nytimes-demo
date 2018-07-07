//
//  ViewController.swift
//  nytimes
//
//  Created by Shantanu Khanwalkar on 06/07/18.
//  Copyright © 2018 Shantanu Khanwalkar. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: - Constants
    
    private let segueArticleDetailView = "showArticle"
    
    // MARK: -
    
    private lazy var dataManager = {
        return DataManager(baseURLString: API.BaseURL)
    }()
    
    private var articles: [Article]? {
        didSet {
            self.tblView.reloadData()
        }
    }
    
    private var selectedArticle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchArticlesData()
    }
    
    // MARK: - Fetch Articles
    private func fetchArticlesData() {
        dataManager.articlesIn(section: "all-sections", period: 7) { (response, error) in
            if let error = error {
                print(error)
            } else if let response = response {
                self.articles = response.results
            }
        }
    }
    
    // MARK: - View Methods

    /// Setting up the table view
    func setupTableView() {
        // Estimated row height of the cell
        tblView.estimatedRowHeight = 66.0
        // Using automatic cell height calculation
        tblView.rowHeight = UITableViewAutomaticDimension
        // Setting the table footer view so that empty cells do not show as separator lines
        tblView.tableFooterView = UIView(frame: CGRect.zero)
        // Registering the reusable cell
        tblView.register(UINib(nibName: CellNames.articleCell, bundle: nil), forCellReuseIdentifier: CellNames.articleCell)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case segueArticleDetailView:
            if let webViewController = segue.destination as? WebViewController {
                webViewController.webUrl = URL(string: selectedArticle)
            } else {
                fatalError("Unexpected Destination View Controller")
            }
        default: break
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        Will only show a table view cell if the array has some value
        return articles == nil ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articles = articles else { return 0 }
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.articleCell, for: indexPath) as? ArticleTableViewCell else { fatalError("Unexpected Table View Cell") }
        
        if let articles = articles {
            let article = articles[indexPath.row]
            cell.lblTitle.text = article.title
            cell.lblByline.text = article.byline
            cell.lblSource.text = article.source
            cell.lblDate.text = article.publishedDate
            cell.setArticleImageView(withMedia: article.media)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let articles = articles {
            selectedArticle = articles[indexPath.row].url
            performSegue(withIdentifier: segueArticleDetailView, sender: self)
        }
    }
}

