//
//  NewsArticleCell.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit
import SDWebImage

class NewsArticleCell: UICollectionViewCell {

  @IBOutlet weak var divider: UIView!
  @IBOutlet weak var cardView: UIView!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var articleCallout: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    cardView.layer.cornerRadius = 8
    cardView.layer.shadowRadius = 8
    cardView.layer.shadowOpacity = 0.15
    cardView.layer.shadowOffset = .zero
    articleImage.layer.cornerRadius = 8
    articleImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    divider.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
  }

  func setup(article: NewsArticleRepresentable) {
    articleImage.sd_setImage(with: article.image, placeholderImage: nil, options: .continueInBackground, context: nil)
    articleTitle.text = article.title
    articleCallout.text = article.callout
  }

  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    layoutIfNeeded()
    let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
    layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
    return layoutAttributes
  }

  override var isHighlighted: Bool {
    didSet {
      UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
        self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 1.02, y: 1.02) : .identity
      })
    }
  }
  
}
