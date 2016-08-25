//
//  NewsInterfaceController.swift
//  Headlines
//
//  Created by Ezequiel Becerra on 8/24/16.
//  Copyright © 2016 Ezequiel Becerra. All rights reserved.
//

import WatchKit
import Foundation

class NewsInterfaceController: WKInterfaceController {
    
    var news: [News]?
    
    @IBOutlet var newsTable: WKInterfaceTable!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        guard let title = context?["title"] as? String,
            news = context?["elements"] as? [News] else {
            return
        }
        
        let sortedNews = news.sort { $0.date!.compare($1.date!) == .OrderedDescending }
        
        self.setTitle(title)
        self.newsTable.setNumberOfRows(sortedNews.count, withRowType: "NewsRow")
        
        for (index, n) in sortedNews.enumerate() {
            let row = self.newsTable.rowControllerAtIndex(index) as! NewsRowController
            row.titleLabel.setText(n.title)
            row.sourceLabel.setText(n.source)
            row.date = n.date
        }
    }
}