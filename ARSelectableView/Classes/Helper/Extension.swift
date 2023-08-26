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
        dequeueReusableCell(withReuseIdentifier: String.init(describing: cell), for: indexpath) as? T
    }
    
    func register<T: UICollectionViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        register(UINib.init(nibName: String(describing: T.self), bundle: Bundle.main),
                 forCellWithReuseIdentifier: String(describing: T.self))
    }
}

extension UIButton {

    func setTintImage(_ image: UIImage?, tintColor color: UIColor, state: UIControl.State) {

        let tintedImage = image?.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: state)
        tintColor = color
    }
}

extension UILabel {

    func sizeForLabel(text: String, font: UIFont) -> CGSize {

        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
