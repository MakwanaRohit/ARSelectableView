//
//  ARSelectableCell.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

struct ARColor {
    var selectedBackgroundColor: UIColor = UIColor.black
    var defaultBackgroundColor: UIColor = UIColor.blue
    var selectedTextColor: UIColor = UIColor.black
    var defaultTextColor: UIColor = UIColor.blue
    var buttonTintColor : UIColor = UIColor.black
}

protocol ARSelectionDelegate: AnyObject {
    func ARSelectionAction(_ selectItem: ARSelectModel)
}

class ARSelectableCell: UICollectionViewCell {

    // MARK: - Declared Variables
    var fittingSize: CGSize {
        return self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    public var selectedButtonColor : UIColor = .black
    public var defaultButtonColor : UIColor = .black
    public var selectedTitleColor : UIColor = .black
    public var defaultTitleColor : UIColor = .black
    public var selectedCellBGColor : UIColor = .white
    public var defaultCellBGColor : UIColor = .white

    weak var delegate :ARSelectionDelegate?
    var alignment : ARSelectionAlignment = ARSelectionAlignment.left {
        didSet {
            if self.stackView.subviews.count > 0 {
                if alignment == .left {
                    self.selectButton.removeFromSuperview()
                    self.titleLabel.removeFromSuperview()
                    self.stackView.insertArrangedSubview(self.selectButton, at: 0)
                    self.stackView.insertArrangedSubview(self.titleLabel, at: 1)
                }
                else {
                    self.selectButton.removeFromSuperview()
                    self.stackView.insertArrangedSubview(self.selectButton, at: 1)
                }
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
        label.font            = UIFont.systemFont(ofSize : 15)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()

    var selectItem: ARSelectModel? {
        didSet {
            if let select = self.selectItem {
                self.titleLabel.text = select.title
                self.selectButton.setTintImage(select.selectionType!.defaultImage,
                                               tintColor: self.defaultButtonColor, state: .normal)
                self.selectButton.setTintImage(select.selectionType!.selectedImage,
                                               tintColor: self.selectedButtonColor, state: .selected)
                self.selectButton.isSelected = select.isSelected

                self.backgroundColor = select.isSelected ? selectedCellBGColor : defaultCellBGColor
                self.titleLabel.textColor = select.isSelected ? selectedTitleColor : defaultTitleColor

                if select.selectionType == .tags {
                    self.layer.cornerRadius = 5
                    self.selectButton.isHidden = true
                }
            }
        }
    }

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
}
