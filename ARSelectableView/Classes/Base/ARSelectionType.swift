//
//  ARSelectionType.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 05/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit
/**
Enum of selection types used for ARSelectableView.

- radio:              selection type radio.
- checkbox:       selection type checkbox.
- tags:               selection type tags.
 
**/

public enum ARSelectionType: Int {

    case radio
    case checkbox
    case tags

    var defaultImage: UIImage? {
        switch self {
        case .radio:
            return UIImage(systemName: "circle")
        case .checkbox, .tags:
            return UIImage(systemName: "square")
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .radio:
            return UIImage(systemName: "circle.inset.filled")
        case .checkbox, .tags:
            return UIImage(systemName: "checkmark.square.fill")
        }
    }
}
