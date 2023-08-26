//
//  ARSelectModel.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 05/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

public class ARSelectModel {
    
    private(set) var title: String
    private(set) var isSelected: Bool
    private(set) var width: CGFloat = 0.0
    private(set) var selectionType: ARSelectionType
    
    init(title: String,
        isSelected: Bool = false,
        selectionType : ARSelectionType = .radio) {
        
        self.title = title
        self.isSelected = isSelected
        self.selectionType = selectionType
        self.width = UILabel().sizeForLabel(text: title, font: ARSelectableCell.titleFont).width
    }
    
    func setSelected(_ isSelected: Bool = false) {
        self.isSelected = isSelected
    }
    
    func toggleSelection() {
        self.isSelected.toggle()
    }
    
    func updateWidth(_ width: CGFloat) {
        self.width = width
    }
    
    func updateSelectionType(_ type: ARSelectionType) {
        self.selectionType = type
    }
}
