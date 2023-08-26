//
//  ARSelectableCell.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

final class ARSelectableCell: UICollectionViewCell {

    // MARK: - Declared Variables
    var fittingSize: CGSize {
        return systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    static let CELL_EXTRA_SPACE: CGFloat = 55
    static let titleFont = UIFont.systemFont(ofSize : 15)
    fileprivate var selectItem: ARSelectModel?

    var alignment: ARSelectionAlignment = ARSelectionAlignment.left {
        didSet {
            selectButton.removeFromSuperview()
        titleLabel.removeFromSuperview()

            if alignment == .right {
                stackView.addArrangedSubview(titleLabel)
                stackView.addArrangedSubview(selectButton)
            }
            else {
                stackView.addArrangedSubview(selectButton)
                stackView.addArrangedSubview(titleLabel)
            }
            stackView.setNeedsDisplay()
            stackView.layoutIfNeeded()
        }
    }

    fileprivate let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        return stackView
    }()

    fileprivate let selectButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.isUserInteractionEnabled = false
        return btn
    }()

    fileprivate var titleLabel: UILabel = {
        let label             = UILabel(frame: CGRect())
        label.textAlignment   = .left
        label.textColor       = .black
        label.font            = ARSelectableCell.titleFont
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Init Variables
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helper Variables
    fileprivate func addViews() {

        selectButton.removeFromSuperview()
        titleLabel.removeFromSuperview()
        
        addSubview(stackView)
        
		stackView.backgroundColor = .clear
        stackView.addArrangedSubview(selectButton)
        stackView.addArrangedSubview(titleLabel)

        NSLayoutConstraint.activate([selectButton.heightAnchor.constraint(equalToConstant: 25),
                                     selectButton.widthAnchor.constraint(equalToConstant: 25)])

        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
                                     stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                                     stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)])
    }

    // MARK: - Confige Cell
    func configeCell(_ selectItem: ARSelectModel?,
                     designOptions: ARCellDesignDefaults? = ARCellDesignDefaults(),
                     alignment : ARSelectionAlignment = ARSelectionAlignment.left) {

        if let select = selectItem, let options = designOptions {

            self.selectItem = selectItem
            titleLabel.text = select.title
            titleLabel.textColor = select.isSelected ? options.selectedTitleColor : options.defaultTitleColor
            
            backgroundColor = select.isSelected ? options.selectedCellBGColor : options.defaultCellBGColor
            layer.cornerRadius = options.cornerRadius
            
            selectButton.isHidden = !options.isShowButton
            selectButton.isSelected = select.isSelected
            selectButton.setTintImage(select.isSelected ? select.selectionType.selectedImage : select.selectionType.defaultImage,
                                           tintColor: select.isSelected ? options.selectedSelectionColor : options.defaultSelectionColor,
                                           state: select.isSelected ? .selected: .normal)
        }
    }
}
