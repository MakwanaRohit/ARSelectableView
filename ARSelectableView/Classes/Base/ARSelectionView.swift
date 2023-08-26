//
//  ARSelectionView.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

protocol ARSelectionViewDelegate: AnyObject {
    func selectionMaxLimitReached( _ selectionView: ARSelectionView)
}

public final class ARSelectionView: UIView {

    // MARK: - Declared Variables
    public static let DEFAULT_LINE_SPACING: CGFloat = 0
    public static let DEFAULT_INTERITEM_SPACING : CGFloat = 0
    
    weak var delegate: ARSelectionViewDelegate?

    private var reseource: (cell: ARSelectableCell?, identifier: String)?
    var cellDesignDefaults = ARCellDesignDefaults()
    lazy var tagLayout = ARFlowLayout()
    var maxSelectCount : Int?

    var options: ARCollectionLayoutDefaults = ARCollectionLayoutDefaults() {
        didSet{
            tagLayout.sectionInset = options.sectionInset
            tagLayout.minimumInteritemSpacing = options.interitemSpacing
            tagLayout.minimumLineSpacing = options.lineSpacing
            tagLayout.scrollDirection = options.scrollDirection
            if selectionType == .tags && options.scrollDirection != .horizontal {
                tagLayout.align = alignment == .right ? .right : .left
            }
            else {
                tagLayout.align = .none
            }
            collectionView.collectionViewLayout = tagLayout
            collectionView.reloadData()
        }
    }

    var alignment: ARSelectionAlignment = .left {
        didSet {
            if selectionType == .tags && options.scrollDirection != .horizontal {
                tagLayout.align = alignment == .right ? .right : .left
            }
            else {
                tagLayout.align = .none
            }
            collectionView.reloadData()
        }
    }

    var selectionType : ARSelectionType? {
        didSet {
            if let selectionType = selectionType {
                if selectionType == .tags && options.scrollDirection != .horizontal {
                    tagLayout.align = alignment == .right ? .right : .left
                }
                else {
                    tagLayout.align = .none
                }
                collectionView.collectionViewLayout = tagLayout
                items.forEach { $0.updateSelectionType( selectionType ) }
                collectionView.reloadData()
            }
        }
    }

    fileprivate lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.bounces = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ARSelectableCell.self, forCellWithReuseIdentifier: String(describing: ARSelectableCell.self))
        return cv
    }()

    private var items: [ARSelectModel] = [] {
        didSet {
            if let selectionType = selectionType {
                items.forEach { $0.updateSelectionType( selectionType ) }
            }
            collectionView.reloadData()
            layoutIfNeeded()
        }
    }

    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addViews()
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func addViews() {
        setupCollectionView()
    }

    // MARK: - Hepler Methods
    private func setupCollectionView() {

        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

        reseource = (cell: ARSelectableCell(), String(describing: ARSelectableCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: topAnchor),
                                     collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.rightAnchor.constraint(equalTo: rightAnchor)])
    }

    fileprivate func updateSelection(_ selectItem: ARSelectModel) {

        let status = selectItem.isSelected
        if selectionType == .radio {
            items.forEach { ($0).setSelected() }
            selectItem.setSelected(!status)
            collectionView.reloadData()
        }
        else {
            if let maxCount = maxSelectCount, !selectItem.isSelected {
                let count = items.filter { $0.isSelected == true }.count
                if count < maxCount {
                    selectItem.toggleSelection()
                    collectionView.reloadData()
                } else {
                    delegate?.selectionMaxLimitReached(self)
                }
            } else {
                selectItem.toggleSelection()
                collectionView.reloadData()
            }
        }
    }
    
    func configureItems(_ items: [ARSelectModel] ) {
        self.items = items
    }
    
    func resetSelection() {
        items.forEach { $0.setSelected() }
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension ARSelectionView: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueCell(ARSelectableCell.self, indexpath: indexPath) {
            cell.alignment = alignment
            cell.configeCell(items[indexPath.row], designOptions: cellDesignDefaults)
            cell.layoutIfNeeded()
            return cell
        }
        return UICollectionViewCell()
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelection(items[indexPath.row])
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension ARSelectionView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if selectionType == .tags {
            guard let cell = reseource?.cell else { return .zero }
            cell.configeCell(items[indexPath.row], designOptions: cellDesignDefaults)
            let size = cell.fittingSize
            return CGSize(width: size.width, height: cellDesignDefaults.rowHeight)
        } else {
            if options.scrollDirection == .horizontal {
                return CGSize(width: items[indexPath.row].width, height: cellDesignDefaults.rowHeight)
            } else {
                return CGSize(width: frame.width, height: cellDesignDefaults.rowHeight)
            }
        }
    }
}
