//
//  NewsViewModel.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

class NewsViewModel: NewsViewModelInterface {

  private weak var view: NewsViewInterface?
  private let newsRepository: NewsArticleRepositoryInterface
  private weak var coordinator: Coordinator?

  private var articles = [NewsArticle]()

  private lazy var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.doesRelativeDateFormatting = true
    formatter.timeStyle = .short
    return formatter
  }()

  init(newsRepository: NewsArticleRepositoryInterface, coordinator: Coordinator) {
    self.newsRepository = newsRepository
    self.coordinator = coordinator
  }

  func onViewDidLoad(_ view: NewsViewInterface) {
    self.view = view
    getNews()
  }

  func onTapArticle(index: Int) {
    coordinator?.showArticle(url: articles[index].url)
  }

  private func getNews() {
    newsRepository.retrieveTopHeadlines { [weak self] (result) in
      guard let self = self else { return }
      switch result {
      case .success(let articles):
        self.articles = articles.sorted()
        let representables = self.articles.map { NewsArticleRepresentable(article: $0, formatter: self.formatter) }
        DispatchQueue.main.async {
          self.view?.articles = representables
        }
      case .failure(let error):
        print(error)
      }
    }
  }

}

private extension NewsArticleRepresentable {

  init(article: NewsArticle, formatter: DateFormatter) {
    self.title = article.title
    self.image = article.urlToImage
    if let author = article.author {
      self.callout = "\(author) • \(formatter.string(from: article.publishedAt))"
    } else {
      self.callout = formatter.string(from: article.publishedAt)
    }
  }

}
