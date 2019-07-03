//
//  NewsAPI.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import Foundation

protocol NewsAPIInterface {
  func retrieveTopHeadlines(_ completion: @escaping (Result<[NewsArticle], Error>) -> Void)
}

class NewsAPI: NewsAPIInterface {

  private let service: NetworkServiceInterface

  private struct NewsResponse: Codable {
    let articles: [NewsArticle]
  }

  init(service: NetworkServiceInterface) {
    self.service = service
  }

  func retrieveTopHeadlines(_ completion: @escaping (Result<[NewsArticle], Error>) -> Void) {
    var urlComponents = URLComponents(string: "https://newsapi.org/v2/top-headlines")
    let sourceQuery = URLQueryItem(name: "sources", value: "talksport")
    let apiItem = URLQueryItem(name: "apiKey", value: "74c46697d0f24826a8ba6bd747332e23")
    urlComponents?.queryItems = [sourceQuery, apiItem]

    guard let url = urlComponents?.url else {
      completion(.failure(NetworkError.invalidRequest))
      return
    }

    service.handleRequest(URLRequest(url: url), decodingTo: NewsResponse.self) { (result) in
      switch result {
      case .success(let response):
        completion(.success(response.articles))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

}
