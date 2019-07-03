//
//  NewsArticle.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

struct NewsArticle {

  struct Source: Codable {
    let id: String
    let name: String
  }

  let source: Source
  let author: String?
  let title: String
  let description: String
  let publishedAt: Date
  let url: URL
  let urlToImage: URL
}

extension NewsArticle: Codable {}

extension NewsArticle: Comparable {

  static func < (lhs: NewsArticle, rhs: NewsArticle) -> Bool {
    return lhs.publishedAt > rhs.publishedAt
  }

  static func == (lhs: NewsArticle, rhs: NewsArticle) -> Bool {
    return lhs.url == rhs.url
  }

}
