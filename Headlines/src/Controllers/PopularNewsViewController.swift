//
//  PopularNewsViewController.swift
//  Headlines
//
//  Created by Ezequiel Becerra on 5/14/17.
//  Copyright © 2017 Ezequiel Becerra. All rights reserved.
//

import UIKit

class PopularNewsViewController: NewsTableViewController {
    
    let newsService = NewsService()
    
    // MARK: Private
    func fetchRequestNews() {
        refreshControl?.beginRefreshing()
        
        newsService.requestPopularNews(success: { (result) in
            self.refreshControl?.endRefreshing()
            
            guard let r = result else {
                return
            }
            
            self.news.removeAll()
            self.news.append(contentsOf: r)
            
            self.tableView.reloadData()
            
        }) { (error) in
            self.refreshControl?.endRefreshing()
            
            print("\(error.localizedDescription)")
        }
    }
    
    // MARK: Public
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  Setup refresh control
        let refreshCtrl = UIRefreshControl()
        tableView.refreshControl = refreshCtrl
        
        refreshCtrl.tintColor = UIColor(red:0.99, green:0.29, blue:0.39, alpha:1.00)
        refreshCtrl.addTarget(self, action: #selector(fetchRequestNews), for: .valueChanged)
        
        //  Had to set content offset because of UIRefreshControl bug
        //  http://stackoverflow.com/a/31224299/994129
        tableView.contentOffset = CGPoint(x:0, y:-refreshCtrl.frame.size.height)
        
        fetchRequestNews()
    }
}