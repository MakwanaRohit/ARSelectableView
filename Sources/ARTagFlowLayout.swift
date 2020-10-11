//
//  ARTagFlowLayout.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 04/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

public class ARTagFlowLayout: UICollectionViewFlowLayout {

    typealias AlignType = (lastRow: Int, lastMargin: CGFloat)
    var align: ARSelectionAlignment = .left

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        guard let collectionView = collectionView else { return nil }
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        guard let attributesToReturn =  attributes.map( { $0.copy() } ) as? [UICollectionViewLayoutAttributes] else {
            return nil
        }

        let shifFrame: ((UICollectionViewLayoutAttributes) -> Void) = { [unowned self] layoutAttribute in
            if layoutAttribute.frame.origin.x + layoutAttribute.frame.size.width > collectionView.bounds.size.width {
                layoutAttribute.frame.size.width = collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right
            }
        }

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        var alignData: [AlignType] = []

        attributesToReturn.forEach { layoutAttribute in
            switch align {
            case .left, .right:
                if layoutAttribute.frame.origin.y >= maxY {
                    alignData.append((lastRow: layoutAttribute.indexPath.row, lastMargin: leftMargin - minimumInteritemSpacing))
                    leftMargin = sectionInset.left
                }

                shifFrame(layoutAttribute)
                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY , maxY)
            case .none:
                break
            }
        }
        align(attributes: attributesToReturn, alignData: alignData, leftMargin: leftMargin - minimumInteritemSpacing)
        return attributesToReturn
    }

    private func align(attributes: [UICollectionViewLayoutAttributes], alignData: [AlignType], leftMargin: CGFloat) {
        guard let collectionView = collectionView else { return }

        switch align {
        case .left:
            break
        case .right:
            attributes.forEach { layoutAttribute in
                if let data = alignData.filter({ $0.lastRow > layoutAttribute.indexPath.row }).first {
                    layoutAttribute.frame.origin.x += (collectionView.bounds.size.width - data.lastMargin - sectionInset.right)
                } else {
                    layoutAttribute.frame.origin.x += (collectionView.bounds.size.width - leftMargin - sectionInset.right)
                }
            }
        case .none:
            break
        }
    }
}

enum ARSelectionAlignment {
    case left
    case right
    case none
}
