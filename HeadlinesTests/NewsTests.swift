//
//  NewsParsingTests.swift
//  HeadlinesTests
//
//  Created by Ezequiel Becerra on 01/08/2018.
//  Copyright © 2018 Ezequiel Becerra. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Canillitapp

class NewsTests: XCTestCase {
    
    func decodeNews(from data: Data) -> [News] {
        // Decoding Data into News
        // (replace this with Decodable snippet in the future)
        let json = try? JSON(data: data)
        
        var news = [News]()
        for (_, v) in json! {
            let n = News(json: v)
            news.append(n)
        }
        return news
    }
    
    func testNewsParsingWithNullOrWrongURL() {
        let path = Bundle.init(for: NewsTests.self).path(forResource: "news_null_or_wrong_url_mock", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        
        let news = decodeNews(from: data!)
        
        // Array should not be null
        XCTAssertNotNil(news)
        
        // News should be parsed anyways
        XCTAssert(news.count == 3)
        
        news.forEach { (n) in
            // News should have url == nil
            XCTAssertNil(n.url)
        }
    }
    
    func testNewsParsingWithNullOrWrongIdentifier() {
        let path = Bundle
                    .init(for: NewsTests.self)
                    .path(forResource: "news_null_or_wrong_identifier_mock", ofType: "json")
        
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        
        let news = decodeNews(from: data!)
        
        // Array should not be null
        XCTAssertNotNil(news)
        
        // Not having identifier is considered a critical error,
        // so News should not be parsed anyways
        XCTAssert(news.count == 0)
    }
    
    func testNewsParsingWithNullTitle() {
        let path = Bundle
            .init(for: NewsTests.self)
            .path(forResource: "news_null_title_mock", ofType: "json")
        
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        
        let news = decodeNews(from: data!)
        
        // Array should not be null
        XCTAssertNotNil(news)
        
        // Not having title is considered a critical error,
        // so News should not be parsed anyways
        XCTAssert(news.count == 0)
    }
    
    func testNewsParsingWithNullOrWrongDate() {
        let path = Bundle
            .init(for: NewsTests.self)
            .path(forResource: "news_null_or_wrong_date_mock", ofType: "json")
        
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        
        let news = decodeNews(from: data!)
        
        // Array should not be null
        XCTAssertNotNil(news)
        
        // Not having date is considered a critical error,
        // so News should not be parsed anyways
        XCTAssert(news.count == 0)
    }
    
    func testNewsParsing() {
        let path = Bundle
            .init(for: NewsTests.self)
            .path(forResource: "news_mock", ofType: "json")
        
        let url = URL(fileURLWithPath: path!)
        let data = try? Data(contentsOf: url)
        
        let news = decodeNews(from: data!)
        
        // Array should not be null
        XCTAssertNotNil(news)
        
        // All should be good
        XCTAssert(news.count == 4)
        
        news.forEach { (n) in
            XCTAssertNotNil(n.identifier)
            XCTAssertNotNil(n.title)
            XCTAssertNotNil(n.url)
            XCTAssertNotNil(n.date)
            XCTAssertNotNil(n.source)
            XCTAssertNotNil(n.imageUrl)
            XCTAssertNotNil(n.reactions)
        }
        
        XCTAssert(news.first!.identifier! == "527386")
        XCTAssert(news.first!.url == URL(string: "http://www.lanacion.com.ar/2158062-el-turf-vuelve-a-manifestarse-contra-la-derogacion-de-la-ley-bonaerense-con-el-apoyo-de-juan-carr")!)
        XCTAssert(news.first!.title == "El turf vuelve a manifestarse contra la derogación de la ley bonaerense, con el apoyo de Juan Carr")
        XCTAssert(news.first!.date == Date(timeIntervalSince1970: 1533083699))
        XCTAssert(news.first!.category == "Actualidad")
        XCTAssert(news.first!.source == "La Nacion")
        XCTAssert(news.first!.imageUrl == URL(string: "https://bucket2.glanacion.com/anexos/fotos/93/2738693.jpg")!)
        
        // TODO: add reactions and category to the mock
    }
}
