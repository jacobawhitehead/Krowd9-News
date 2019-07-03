//
//  FlowLayout.swift
//  Krowd9 News
//
//  Created by Jacob Whitehead on 02/07/2019.
//  Copyright © 2019 Jacob. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {

  override init() {
    super.init()

    self.minimumInteritemSpacing = 8
    self.minimumLineSpacing = 4
    self.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    estimatedItemSize = UICollectionViewFlowLayout.automaticSize
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let layoutAttributes = super.layoutAttributesForItem(at: indexPath), let collectionView = collectionView else { return nil }
    layoutAttributes.bounds.size.width = collectionView.safeAreaLayoutGuide.layoutFrame.width - sectionInset.left - sectionInset.right
    return layoutAttributes
  }

  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let superLayoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }

    let computedAttributes = superLayoutAttributes.compactMap { layoutAttribute in
      return layoutAttribute.representedElementCategory == .cell ? layoutAttributesForItem(at: layoutAttribute.indexPath) : layoutAttribute
    }
    return computedAttributes
  }

  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }

}
