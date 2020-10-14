//
//  ARSelectableCell.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

protocol ARSelectionDelegate: AnyObject {
    func ARSelectionAction(_ selectItem: ARSelectModel)
}

public class ARSelectableCell: UICollectionViewCell {

    // MARK: - Declared Variables
    var fittingSize: CGSize {
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    static let CELL_EXTRA_SPACE: CGFloat = 55
    static let titleFont = UIFont.systemFont(ofSize : 15)
    fileprivate var selectItem: ARSelectModel?
    weak var delegate :ARSelectionDelegate?

    var alignment: ARSelectionAlignment = ARSelectionAlignment.left {
        didSet {
            self.selectButton.removeFromSuperview()
            self.titleLabel.removeFromSuperview()

            if alignment == .right {
                self.stackView.addArrangedSubview(self.titleLabel)
                self.stackView.addArrangedSubview(self.selectButton)
            }
            else {
                self.stackView.addArrangedSubview(self.selectButton)
                self.stackView.addArrangedSubview(self.titleLabel)
            }
            self.stackView.setNeedsDisplay()
            self.stackView.layoutIfNeeded()
        }
    }

    fileprivate let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        return stackView
    }()

    fileprivate let selectButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
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

        self.selectButton.removeFromSuperview()
        self.titleLabel.removeFromSuperview()

        self.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.selectButton)
        self.stackView.addArrangedSubview(self.titleLabel)

        self.selectButton.addTarget(self, action: #selector(self.selectButtonAction(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([self.selectButton.heightAnchor.constraint(equalToConstant: 25),
                                     self.selectButton.widthAnchor.constraint(equalToConstant: 25)])

        NSLayoutConstraint.activate([self.stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                                     self.stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
                                     self.stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                                     self.stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10)])
    }

    // MARK: - UIButton Action
    @objc func selectButtonAction(_ button: UIButton) {
        self.delegate?.ARSelectionAction(self.selectItem!)
    }

    // MARK: - Confige Cell
    func configeCell(_ selectItem: ARSelectModel?,
                     designOptions: ARCellDesignDefaults? = ARCellDesignDefaults(),
                     alignment : ARSelectionAlignment = ARSelectionAlignment.left) {

        if let select = selectItem, let options = designOptions {

            self.selectItem = selectItem
            self.titleLabel.text = select.title
            self.titleLabel.textColor = select.isSelected ? options.selectedTitleColor : options.defaultTitleColor
            self.backgroundColor = select.isSelected ? options.selectedCellBGColor : options.defaultCellBGColor
            self.layer.cornerRadius = options.cornerRadius

            self.selectButton.isHidden = !options.isShowButton
            self.selectButton.isSelected = select.isSelected
            self.selectButton.setTintImage(select.isSelected ? select.selectionType!.selectedImage : select.selectionType!.defaultImage,
                                           tintColor: select.isSelected ? options.selectedButtonColor : options.defaultButtonColor,
                                           state: select.isSelected ? .selected: .normal)
        }
    }
}
