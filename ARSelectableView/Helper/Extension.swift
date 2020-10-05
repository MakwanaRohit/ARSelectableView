//
//  Extension.swift
//  ARSelectableView
//
//  Created by Rohit Makwana on 03/10/20.
//  Copyright © 2020 Rohit Makwana. All rights reserved.
//

import UIKit

extension UICollectionView {

    func dequeueCell<T:UICollectionViewCell>(_ cell :T.Type, indexpath: IndexPath) -> T? {
        return self.dequeueReusableCell(withReuseIdentifier:  String.init(describing: cell), for: indexpath) as? T
    }

    func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        self.register(UINib.init(nibName: String(describing: T.self), bundle: Bundle.main), forCellWithReuseIdentifier: String(describing: T.self))
    }
}

extension UIButton {

    func setTintImage(_ image: UIImage, tintColor color: UIColor, state: UIControl.State) {
        let tintedImage = image.withRenderingMode(.alwaysTemplate)
        self.setImage(tintedImage, for: state)
        self.tintColor = color
    }
}
