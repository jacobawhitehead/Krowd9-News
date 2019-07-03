//
//  NewsViewController.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit

class NewsViewController: UIViewController, Storyboarded, NewsViewInterface {

  var articles = [NewsArticleRepresentable]() {
    didSet {
      activityIndicator.stopAnimating()
      collectionView.reloadData()
    }
  }

  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var collectionView: UICollectionView!

  var viewModel: NewsViewModelInterface?

  private let collectionBorder: CGFloat = 8

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.collectionViewLayout = FlowLayout()
    viewModel?.onViewDidLoad(self)
  }

}

extension NewsViewController: UICollectionViewDataSource {

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return articles.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsArticleCell", for: indexPath) as! NewsArticleCell
    cell.setup(article: articles[indexPath.row])
    return cell
  }

}

extension NewsViewController: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    viewModel?.onTapArticle(index: indexPath.row)
  }

}

extension NewsViewController: UICollectionViewDataSourcePrefetching {

  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    SDWebImagePrefetcher.shared.prefetchURLs(articles.map { $0.image } )
  }

  func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
    SDWebImagePrefetcher.shared.cancelPrefetching()
  }

}
