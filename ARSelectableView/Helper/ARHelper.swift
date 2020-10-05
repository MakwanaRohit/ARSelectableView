//
//  ARHelper.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 05/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

struct ARTitle {

    static let selectionType = "Selection Type"
    static let radio = "Radio"
    static let checkbox = "Checkbox"
    static let tags = "Tags"
}

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
}

extension ARSelectionView.Options {
    enum Alignment {
        case justified
        case left
        case center
        case right
    }
}
