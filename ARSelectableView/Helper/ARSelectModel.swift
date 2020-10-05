//
//  ARSelectModel.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 05/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import Foundation

class ARSelectModel {

    var title: String
    var isSelected : Bool
    var selectionType: ARSelectionType?

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
    }
}
