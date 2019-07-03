//
//  Coordinator.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit

protocol Coordinator: class {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
  func start()
  func showArticle(url: URL)
}

class MainCoordinator: Coordinator {
  var childCoordinators = [Coordinator]()
  var navigationController: UINavigationController

  private let networkService: NetworkServiceInterface

  init(navigationController: UINavigationController = UINavigationController(), networkService: NetworkServiceInterface) {
    self.navigationController = navigationController
    self.networkService = networkService
  }

  func start() {
    let newsViewController = NewsViewController.instantiate()
    let newsAPI = NewsAPI(service: networkService)
    let database = NewsDatabase()
    newsViewController.viewModel = NewsViewModel(newsRepository: NewsArticleRepository(api: newsAPI, database: database), coordinator: self)
    navigationController.pushViewController(newsViewController, animated: false)
  }

  func showArticle(url: URL) {
    let articleViewController = NewsArticleViewController.instantiate()
    articleViewController.articleUrl = url
    navigationController.pushViewController(articleViewController, animated: true)
  }

}
