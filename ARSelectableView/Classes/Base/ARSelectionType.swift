//
//  ARSelectionType.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 05/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

public enum ARSelectionType: Int {

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
