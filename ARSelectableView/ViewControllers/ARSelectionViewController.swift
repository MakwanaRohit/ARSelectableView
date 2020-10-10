//
//  ARSelectionViewController.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

class ARSelectionViewController: UIViewController {

    private let width = UIScreen.main.bounds.size.width
    private let height = UIScreen.main.bounds.size.height

    //MARK: - Declared Variables
    fileprivate var selectionView: ARSelectionView?
    fileprivate var selectionOptions: [ARSelectionType] = [.radio, .checkbox, .tags]
    fileprivate var directionOptions: [ARScrollDirection] = [.vertical, .horizontal]
    fileprivate var alignmentOptions: [ARSelectionAlignment] = [.left, .right]
    fileprivate let noOfRow: CGFloat = 5
    
    fileprivate var refreshButtonItem : UIBarButtonItem!
    fileprivate var alignButtonItem : UIBarButtonItem!

    var alignment: ARSelectionAlignment = ARSelectionAlignment.left {
        willSet {
            if newValue != self.alignment {
                DispatchQueue.main.async {
                    self.setSelectionViewOptions(self.currentSelectionType)
                }
            }
        }
    }

    var currentSelectionType: ARSelectionType = ARSelectionType.radio {
        willSet {
            if newValue != self.currentSelectionType {
                self.navigationItem.leftBarButtonItem?.isEnabled = newValue != .tags
                DispatchQueue.main.async {
                    self.setSelectionViewOptions(self.currentSelectionType)
                }
            }
        }
    }

    var scrollDirection = ARScrollDirection.vertical {
        willSet {
            if newValue != self.scrollDirection {
                DispatchQueue.main.async {
                    self.setSelectionViewOptions(self.currentSelectionType)
                }
            }
        }
    }

    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
        self.title = "Selection"

        self.refreshButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.showSelectionOption))
        self.alignButtonItem = UIBarButtonItem(title: "Align", style: .plain, target: self, action: #selector(self.showAlignmentOptions))

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Direction", style: .plain, target: self, action: #selector(self.showDirectionOptions))
        self.navigationItem.rightBarButtonItems = [self.alignButtonItem, self.refreshButtonItem]

        self.setSelectionViewOptions()
    }

    //MARK: - Design Layout
    fileprivate func addSelectionView() {

        self.selectionView?.removeFromSuperview()
        self.selectionView = ARSelectionView(frame: CGRect.zero)
        self.view.addSubview(self.selectionView!)

        selectionView?.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        var constraints = [self.selectionView!.topAnchor.constraint(equalTo: guide.topAnchor),
                           self.selectionView!.leftAnchor.constraint(equalTo: view.leftAnchor),
                           self.selectionView!.rightAnchor.constraint(equalTo: view.rightAnchor)]

        if self.scrollDirection == .vertical {
            constraints.append(self.selectionView!.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        }
        else {
            //Change height as per requirement
            constraints.append(self.selectionView!.heightAnchor.constraint(equalToConstant: self.selectionView!.rowHeight*noOfRow))
        }

        NSLayoutConstraint.activate(constraints)
    }

    fileprivate func setSelectionViewOptions(_ selectionType: ARSelectionType = ARSelectionType.radio) {

        self.addSelectionView()
        self.view.layoutIfNeeded()

        if selectionType == ARSelectionType.tags {
            self.selectionView?.rowHeight = 40
            self.selectionView?.selectedTitleColor = .white
            self.selectionView?.defaultTitleColor = .black
            self.selectionView?.selectedCellBGColor = .black
            self.selectionView?.defaultCellBGColor = UIColor.lightGray.withAlphaComponent(0.3)
            self.selectionView?.options = ARSelectionView.Options(sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),lineSpacing: 10, interitemSpacing: 10, scrollDirection: .vertical)
        }
        else {
            self.selectionView?.options = ARSelectionView.Options(scrollDirection: self.scrollDirection == .vertical ? .vertical: .horizontal)
        }

        self.selectionView?.alignment = self.alignment
        self.selectionView?.selectionType = selectionType

        let items = self.getDummyItems()
        let chunkeditems = items.chunked(into: Int(noOfRow))
        for insa in chunkeditems {
            let maxHeight = (insa.map { $0.width }.max() ?? width/2) + ARSelectableCell.extraSpace
            insa.forEach {$0.width = maxHeight }
        }

        DispatchQueue.main.async {
            self.selectionView?.items = items
        }
    }

    //MARK: - Layout Options

    /// Show actionsheet for selection options
    @objc private func showSelectionOption() {

        var options = self.selectionOptions
        if scrollDirection == .horizontal {
            options.removeLast()
        }

        let actionSheet = UIAlertController(title: "Selection Type", message: "", preferredStyle: .actionSheet)
        for option in options {
            let action = UIAlertAction(title: option.title, style: .default) { (action) in
                self.currentSelectionType = option
            }
            actionSheet.addAction(action)
        }
        self.present(actionSheet, animated: true, completion: nil)
    }

    /// Show actionsheet for Direction options
    @objc private func showDirectionOptions() {

        let actionSheet = UIAlertController(title: "Direction Type", message: "", preferredStyle: .actionSheet)
        for option in directionOptions {
            let action = UIAlertAction(title: option.title, style: .default) { (action) in
                DispatchQueue.main.async {
                    self.scrollDirection = option
                }
            }
            actionSheet.addAction(action)
        }
        self.present(actionSheet, animated: true, completion: nil)
    }

    /// Show actionsheet for Alignment options
    @objc private func showAlignmentOptions() {

        let actionSheet = UIAlertController(title: "Alignment Type", message: "", preferredStyle: .actionSheet)
        for option in alignmentOptions {
            let action = UIAlertAction(title: option.title, style: .default) { (action) in
                DispatchQueue.main.async {
                    self.alignment = option
                }
            }
            actionSheet.addAction(action)
        }
        self.present(actionSheet, animated: true, completion: nil)
    }

    //MARK: - Static Data
    func getDummyItems() -> [ARSelectModel] {

        return [ARSelectModel(title: "Blues Music"),
                ARSelectModel(title: "Jazz Music"),
                ARSelectModel(title: "Country Music"),
                ARSelectModel(title: "Soul Music"),
                ARSelectModel(title: "Dance Music"),
                ARSelectModel(title: "Hip Hop Music"),
                ARSelectModel(title: "Rhythm and Blues Music"),
                ARSelectModel(title: "Rock and Roll Music"),
                ARSelectModel(title: "Rock Music"),
                ARSelectModel(title: "Blues Music"),
                ARSelectModel(title: "Jazz Music"),
                ARSelectModel(title: "Rhythm and Blues Music"),
                ARSelectModel(title: "Soul Music"),
                ARSelectModel(title: "Rock and Roll Music"),
                ARSelectModel(title: "Rock Music"),
                ARSelectModel(title: "Country Music"),
                ARSelectModel(title: "Blues Music"),
                ARSelectModel(title: "Jazz Music"),
                ARSelectModel(title: "Rhythm and Blues Music"),
                ARSelectModel(title: "Rock and Roll Music"),
                ARSelectModel(title: "Rock Music"),
                ARSelectModel(title: "Country Music"),
                ARSelectModel(title: "Soul Music"),
                ARSelectModel(title: "Dance Music"),
                ARSelectModel(title: "Hip Hop Music"),
                ARSelectModel(title: "Dance Music"),
                ARSelectModel(title: "Hip Hop Music")]
    }
}

