//
//  NewsViewModelTests.swift
//  Krowd9 NewsTests
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import XCTest
@testable import Krowd9_News

class NewsViewModelTests: XCTestCase {

  var viewModel: NewsViewModel!

  private lazy var formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.doesRelativeDateFormatting = true
    formatter.timeStyle = .short
    return formatter
  }()

  let repo = MockNewsArticleRepo()

  override func setUp() {
    viewModel = NewsViewModel(newsRepository: repo, coordinator: MockCoordinator())
  }

  func testLoadData() {
    let view = MockNewsView()

    XCTAssert(view.articles.count == 0, "Should start empty")

    viewModel.onViewDidLoad(view)

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      XCTAssert(view.articles.count == 1, "Should have loaded articles")
      XCTAssert(view.articles[0].callout == "Person • \(self.formatter.string(from: self.repo.date))", "Should have author and then data as callout")
      XCTAssert(view.articles[0].title == "Here is a title", "Should have article title")
      XCTAssert(view.articles[0].image.absoluteString == "www.google.com", "Should have image URL")
    }
  }

}

class MockNewsArticleRepo: NewsArticleRepositoryInterface {

  let date = Date()

  func retrieveTopHeadlines(_ completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
    let mock = NewsArticle(source: NewsArticle.Source(id: "bbc", name: "BBC"), author: "Person", title: "Here is a title", description: "Here is a description", publishedAt: date, url: URL(string: "www.google.com")!, urlToImage: URL(string: "www.google.com")!)

    completion(.success([mock]))
  }

}

class MockCoordinator: Coordinator {

  var didPushNewsArticle = false

  var childCoordinators = [Coordinator]()

  var navigationController = UINavigationController()

  func start() {
  }

  func showArticle(url: URL) {
    didPushNewsArticle = true
  }

}

class MockNewsView: NewsViewInterface {
  var articles = [NewsArticleRepresentable]()
}
