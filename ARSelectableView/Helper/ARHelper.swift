//
//  ARHelper.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 05/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

enum ARSelectionType {
    case radio
    case checkbox
    case tags

    var defaultImage: UIImage {
        switch self {
        case .radio:
            return #imageLiteral(resourceName: "round_empty")
        case .checkbox, .tags:
            return #imageLiteral(resourceName: "unchecked_checkbox")
        }
    }

    var selectedImage: UIImage {
        switch self {
        case .radio:
            return #imageLiteral(resourceName: "round_filled")
        case .checkbox, .tags:
            return #imageLiteral(resourceName: "checked_checkbox")
        }
    }
}

enum ARSelectionAlignment {
    case left
    case right
    case none
}

enum ARScrollDirection {

    case vertical
    case horizontal
}

struct ARCellDesignOptions {

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
