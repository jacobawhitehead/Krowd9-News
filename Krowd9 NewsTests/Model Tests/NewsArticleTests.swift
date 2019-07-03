//
//  NewsArticleTests.swift
//  Krowd9 NewsTests
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

import XCTest
@testable import Krowd9_News

class NewsArticleTests: XCTestCase {

  let loader = JSONLoader()

  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return decoder
  }()

  private struct NewsResponse: Codable {
    let articles: [NewsArticle]
  }

  func testParseJSON() {
    guard let json = loader.loadJSON(from: "article") else {
      XCTFail("Could not load article")
      return
    }

    guard let response = try? decoder.decode(NewsResponse.self, from: json) else {
      XCTFail("Could not parse article data")
      return
    }

    let articles = response.articles

    XCTAssert(articles.count == 1, "Should be one article")
    XCTAssert(articles[0].description == "Test description", "Shouldhave description")
    XCTAssert(articles[0].author == "Test Author", "Should have author")
    XCTAssert(articles[0].source.id == "cnn", "Should have correct id")
    XCTAssert(articles[0].source.name == "CNN", "Should have correct name")
    XCTAssert(articles[0].url.absoluteString == "www.google.com", "Should have correct url")
  }

}
