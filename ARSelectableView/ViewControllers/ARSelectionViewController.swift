//
//  ARSelectionViewController.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.size.width
let height = UIScreen.main.bounds.size.height

class ARSelectionViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var selectionTypeSegment: UISegmentedControl!
    @IBOutlet weak var alignmentSegment: UISegmentedControl!
    @IBOutlet weak var directionSegment: UISegmentedControl!

    //MARK: - Declared Variables
    fileprivate var selectionView: ARSelectionView?
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
        self.setSelectionViewOptions()
    }

    //MARK: - Design Layout
    fileprivate func addSelectionView() {

        self.selectionView?.removeFromSuperview()
        self.selectionView = ARSelectionView(frame: CGRect.zero)
        self.view.addSubview(self.selectionView!)

        self.selectionView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([self.selectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     self.selectionView!.leftAnchor.constraint(equalTo: view.leftAnchor),
                                     self.selectionView!.rightAnchor.constraint(equalTo: view.rightAnchor),
                                     self.selectionView!.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/2)])
    }

    fileprivate func setSelectionViewOptions(_ selectionType: ARSelectionType = ARSelectionType.radio) {

        self.addSelectionView()
        self.view.layoutIfNeeded()

        if selectionType == ARSelectionType.tags {
            var designOption = ARCellDesignOptions()
            designOption.defaultCellBGColor = UIColor.lightGray.withAlphaComponent(0.3)
            designOption.selectedTitleColor = .white
            designOption.selectedCellBGColor = .black
            designOption.selectedButtonColor = .white
            designOption.rowHeight = 40
            designOption.cornerRadius = 5
            self.selectionView?.cellDesignOptions = designOption
            self.selectionView?.options = ARCollectionLayoutOptions(sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),lineSpacing: 10, interitemSpacing: 10, scrollDirection: .vertical)
        }
        else {
            self.selectionView?.cellDesignOptions = ARCellDesignOptions()
            self.selectionView?.options = ARCollectionLayoutOptions(scrollDirection: self.scrollDirection == .vertical ? .vertical: .horizontal)
        }
        
        self.selectionView?.alignment = self.alignment
        self.selectionView?.selectionType = selectionType

        let items = self.getDummyItems()
        let chunkeditems = items.chunked(into: Int((self.selectionView?.frame.height)! / (self.selectionView?.cellDesignOptions.rowHeight)!))
        for insa in chunkeditems {
            let maxHeight = (insa.map { $0.width }.max() ?? width/2) + ARSelectableCell.extraSpace
            insa.forEach {$0.width = maxHeight }
        }

        DispatchQueue.main.async {
            self.selectionView?.items = items
        }
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
//MARK: - Segment IBAction

extension ARSelectionViewController {
    
    @IBAction func selectionTypeValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.currentSelectionType = .radio
        }
        else if sender.selectedSegmentIndex == 1 {
            self.currentSelectionType = .checkbox
        }
        else {
            self.currentSelectionType = .tags
        }
        
        self.setSelectionViewOptions(self.currentSelectionType)
    }
    
    @IBAction func alignmentValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.alignment = .left
        }
        else if sender.selectedSegmentIndex == 1 {
            self.alignment = .right
        }
        self.setSelectionViewOptions(self.currentSelectionType)
    }
    
    @IBAction func directionValueChanged(_ sender: UISegmentedControl) {

        if self.selectionTypeSegment.selectedSegmentIndex == 2 {
            self.directionSegment.selectedSegmentIndex = 0
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "", message: "This selection type not supported horizontal scroll direction", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else {
            if sender.selectedSegmentIndex == 0 {
                self.scrollDirection = .vertical
            }
            else {
                self.scrollDirection = .horizontal
            }
            self.setSelectionViewOptions(self.currentSelectionType)
        }
    }
}
