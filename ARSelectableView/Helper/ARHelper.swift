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

    var title: String {
        switch self {
        case .radio:
            return "Radio"
        case .checkbox:
             return "Checkbox"
        case .tags:
             return "Tags"
        }
    }
}

enum ARSelectionAlignment {
    case left
    case right

    var title: String {
        switch self {
        case .left:
            return "Left"
        case .right:
             return "Right"
        }
    }
}

extension ARSelectionView.Options {
    enum Alignment {
        case justified
        case left
        case center
        case right
        case none
    }
}

enum ARScrollDirection {

    case vertical
    case horizontal

    var title: String {
        switch self {
        case .vertical:
            return "Vertical"
        case .horizontal:
             return "Horizontal"
        }
    }
}
