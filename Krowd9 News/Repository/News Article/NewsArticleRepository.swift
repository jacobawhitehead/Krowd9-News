//
//  NewsArticleRepository.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 03/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation
import Reachability

protocol NewsArticleRepositoryInterface {
  func retrieveTopHeadlines(_ completion: @escaping (Result<[NewsArticle], Error>) -> Void)
}

class NewsArticleRepository: NewsArticleRepositoryInterface {

  private let api: NewsAPIInterface
  private let database: NewsDatabaseInterface
  private let reachability = Reachability()!

  init(api: NewsAPIInterface, database: NewsDatabaseInterface) {
    self.api = api
    self.database = database
  }

  func retrieveTopHeadlines(_ completion: @escaping (Result<[NewsArticle], Error>) -> Void) {

    if reachability.connection == .none {
      completion(.success(database.getSavedModels()))
    } else {
      api.retrieveTopHeadlines { [weak self] (result) in
        switch result {
        case .success(let articles):

          completion(.success(articles))

          self?.database.clearCache()
          for article in articles {
            self?.database.saveModel(article)
          }

        case .failure(let error):
          completion(.failure(error))
        }
      }
    }
  }

}
