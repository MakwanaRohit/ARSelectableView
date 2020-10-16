//
//  ARBasicConfiguration.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 12/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

// CollectionView layout options
public struct ARCollectionLayoutDefaults {

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

// CollectionView cell defaults
public struct ARCellDesignDefaults {

    public var selectedButtonColor : UIColor = .black
    public var defaultButtonColor : UIColor = .black
    public var selectedTitleColor : UIColor = .black
    public var defaultTitleColor : UIColor = .black
    public var selectedCellBGColor : UIColor = .white
    public var defaultCellBGColor : UIColor = .white
    public var rowHeight : CGFloat = 35
    public var isShowButton : Bool = true
    public var cornerRadius : CGFloat = 0
}
