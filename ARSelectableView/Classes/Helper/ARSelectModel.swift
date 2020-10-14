//
//  ARSelectModel.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 05/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

class ARSelectModel {

    var title: String
    var isSelected: Bool
    var selectionType: ARSelectionType?
    var width: CGFloat = 0.0

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
        self.width = UILabel().sizeForLabel(text: title, font: ARSelectableCell.titleFont).width
    }
}
