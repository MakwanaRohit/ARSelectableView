//
//  OptionViewController.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 04/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func optionButtonAction(_ sender: Any) {
        showActionSheet()
    }

    /// Show actionsheet for selection
    func showActionSheet() {

        let actionSheet = UIAlertController(title: ARTitle.selectionType, message: "", preferredStyle: .actionSheet)

        let radio = UIAlertAction(title: ARTitle.radio, style: .default) { (action) in
            self.navigateToSelectionViewController(.radio)
        }

        let checkbox = UIAlertAction(title: ARTitle.checkbox, style: .default) { (action) in
            self.navigateToSelectionViewController(.checkbox)
        }

        let tags = UIAlertAction(title: ARTitle.tags, style: .default) { (action) in
            self.navigateToSelectionViewController(.tags)
        }

        actionSheet.addAction(radio)
        actionSheet.addAction(checkbox)
        actionSheet.addAction(tags)

        self.present(actionSheet, animated: true, completion: nil)
    }

    /// Navigate To SelectionViewController
    func navigateToSelectionViewController(_ type: ARSelectionType) {

        let controller = ARSelectionViewController()
        controller.selectionType = type
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
