//
//  ARSelectionView.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

final class ARSelectionView: UIView {

    // MARK: - Declared Variables
    fileprivate let DEFAULT_LINE_SPACING: CGFloat = 10.0
    fileprivate let DEFAULT_INTERITEM_SPACING : CGFloat = 10.0

    private let tagLayout = ARTagFlowLayout()
    private var reseource: (cell: ARSelectableCell?, identifier: String)?

    public var defaultButtonColor: UIColor? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var selectedButtonColor: UIColor? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var defaultTitleColor: UIColor? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var selectedTitleColor: UIColor? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var defaultCellBGColor: UIColor? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var selectedCellBGColor: UIColor? {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var rowHeight : CGFloat = 25 {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var alignment: ARSelectionAlignment = ARSelectionAlignment.left {
        didSet {
            self.collectionView.reloadData()
        }
    }

    public var selectionType : ARSelectionType = ARSelectionType.radio {
        didSet {
            if selectionType == .tags {
                tagLayout.sectionInset = self.options?.sectionInset ?? UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
                tagLayout.minimumInteritemSpacing = options?.interitemSpacing ?? DEFAULT_INTERITEM_SPACING
                tagLayout.minimumLineSpacing = options?.lineSpacing ?? DEFAULT_LINE_SPACING
                tagLayout.scrollDirection = options?.scrollDirection ?? .vertical
                self.collectionView.collectionViewLayout = self.tagLayout
            }

            self.collectionView.reloadData()
        }
    }

    fileprivate let defaultLayout: UICollectionViewFlowLayout = {
        let _layout = UICollectionViewFlowLayout()
        _layout.scrollDirection = .horizontal
        return _layout
    }()

    fileprivate let collectionView: UICollectionView = {
        let _layout = UICollectionViewFlowLayout()
        _layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: _layout)
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ARSelectableCell.self, forCellWithReuseIdentifier: String(describing: ARSelectableCell.self))
        return cv
    }()

    public var options: ARSelectionView.Options? {
        didSet {
            guard let options = options else { return }
            defaultLayout.sectionInset = options.sectionInset
            defaultLayout.minimumInteritemSpacing = options.interitemSpacing
            defaultLayout.minimumLineSpacing = options.lineSpacing
            defaultLayout.scrollDirection = options.scrollDirection
            self.collectionView.collectionViewLayout = self.defaultLayout
        }
    }

    var items: [ARSelectModel] = [] {
        didSet {
            self.items.forEach { $0.selectionType = self.selectionType }
            self.collectionView.reloadData()
            self.layoutIfNeeded()
        }
    }

    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.addViews()
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func addViews() {

        self.setupCollectionView()
    }

    // MARK: - Hepler Methods
    func setupCollectionView() {

        self.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

        self.reseource = (cell: ARSelectableCell(), String(describing: ARSelectableCell.self))

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: topAnchor),
                                     collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.rightAnchor.constraint(equalTo: rightAnchor)])
    }

    fileprivate func updateSelection(_ selectItem: ARSelectModel) {

        let status = selectItem.isSelected
        if self.selectionType == .radio {
            self.items.filter { $0.isSelected == true }.forEach { ($0).isSelected = false }
            selectItem.isSelected = !status
        }
        else {
            selectItem.isSelected.toggle()
        }
        collectionView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension ARSelectionView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueCell(ARSelectableCell.self, indexpath: indexPath) {

            cell.delegate = self
            if self.alignment == .right && self.selectionType == .checkbox && self.options?.scrollDirection == .vertical {
                cell.alignment = self.alignment
            }

            if let color = self.selectedButtonColor {
                cell.selectedButtonColor = color
            }

            if let color = self.defaultButtonColor {
                cell.defaultButtonColor = color
            }

            if let color = self.selectedTitleColor {
                cell.selectedTitleColor = color
            }

            if let color = self.defaultTitleColor {
                cell.defaultTitleColor = color
            }

            if let color = self.selectedCellBGColor {
                cell.selectedCellBGColor = color
            }

            if let color = self.defaultCellBGColor {
                cell.defaultCellBGColor = color
            }

            cell.selectItem = self.items[indexPath.row]
            cell.layoutIfNeeded()
            return cell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        self.updateSelection(self.items[indexPath.row])
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ARSelectionView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if self.selectionType == .tags {
            guard let cell = reseource?.cell else { return .zero }
            cell.selectItem = self.items[indexPath.row]
            let size = cell.fittingSize
            return CGSize(width: size.width, height: self.rowHeight)
        }
        else {
            if self.options?.scrollDirection == .horizontal {
                return CGSize(width: self.items[indexPath.row].width, height: self.rowHeight)
            }
            else {
                return CGSize(width: self.frame.width, height: self.rowHeight)
            }
        }
    }
}

//MARK:- ARSelectionDelegate
extension ARSelectionView: ARSelectionDelegate {

    func ARSelectionAction(_ selectItem: ARSelectModel) {
        self.updateSelection(selectItem)
    }
}

//MARK:- Layout Options
extension ARSelectionView {

    struct Options {
        public let sectionInset: UIEdgeInsets
        public let lineSpacing: CGFloat
        public let interitemSpacing: CGFloat
        public let scrollDirection : UICollectionView.ScrollDirection

        public init(sectionInset: UIEdgeInsets = .zero,
                    lineSpacing: CGFloat = 10.0,
                    interitemSpacing: CGFloat = 10.0,
                    scrollDirection: UICollectionView.ScrollDirection = .horizontal) {

            self.sectionInset = sectionInset
            self.lineSpacing = lineSpacing
            self.interitemSpacing = interitemSpacing
            self.scrollDirection = scrollDirection
        }
    }
}
