//
//  ARCollectionLayoutOptions.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 11/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

struct ARCollectionLayoutOptions {

    public let sectionInset: UIEdgeInsets
    public let lineSpacing: CGFloat
    public let interitemSpacing: CGFloat
    public let scrollDirection : UICollectionView.ScrollDirection

    public init(sectionInset: UIEdgeInsets = .zero,
                lineSpacing: CGFloat = ARSelectionView.DEFAULT_LINE_SPACING,
                interitemSpacing: CGFloat = ARSelectionView.DEFAULT_INTERITEM_SPACING,
                scrollDirection: UICollectionView.ScrollDirection = .vertical) {

        self.sectionInset = sectionInset
        self.lineSpacing = lineSpacing
        self.interitemSpacing = interitemSpacing
        self.scrollDirection = scrollDirection
    }
}
