//
//  NewsContracts.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

protocol NewsViewInterface: class {
  var articles: [NewsArticleRepresentable] { get set }
}

protocol NewsViewModelInterface {
  func onViewDidLoad(_ view: NewsViewInterface)
  func onTapArticle(index: Int)
}

struct NewsArticleRepresentable {
  let title: String
  let callout: String
  let image: URL
}
