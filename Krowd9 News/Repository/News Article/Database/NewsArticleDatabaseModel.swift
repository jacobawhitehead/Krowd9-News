//
//  NewsArticleDatabaseModel.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import RealmSwift

class NewsArticleDatabaseModel: Object {

  @objc dynamic var author: String? = nil
  @objc dynamic var title = ""
  @objc dynamic var sourceName = ""
  @objc dynamic var sourceId = ""
  @objc dynamic var body = ""
  @objc dynamic var publishedAt = Date(timeIntervalSince1970: 1)
  @objc dynamic var url = ""
  @objc dynamic var image = ""

  convenience init(article: NewsArticle) {
    self.init()
    self.author = article.author
    self.title = article.title
    self.sourceName = article.source.name
    self.sourceId = article.source.id
    self.body = article.description
    self.publishedAt = article.publishedAt
    self.url = article.url.absoluteString
    self.image = article.urlToImage.absoluteString
  }

  func article() -> NewsArticle? {
    guard let url = URL(string: url), let image = URL(string: image) else {
      return nil
    }

    return NewsArticle(source: NewsArticle.Source(id: sourceId, name: sourceName), author: author, title: title, description: body, publishedAt: publishedAt, url: url, urlToImage: image)
  }

}

