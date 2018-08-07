//
//  UIFunc.swift
//  The Genius
//
//  Created by JunsangYu on 31/07/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import Foundation
import UIKit

class UIFunc {
    static func getPos(view: UIView) -> (CGFloat, CGFloat) {
        return (view.frame.width, view.frame.height)
    }
    static func view(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIView {
        let view = UIView()
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        return view
    }
    static func lbl(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, text: String) -> UILabel {
        let view = UILabel()
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.text = text
        return view
    }
    static func btn(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, title: String) -> UIButton {
        let view = UIButton()
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.setTitle(title, for: .normal)
        return view
    }
    static func imgView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, img: UIImage?) -> UIImageView {
        let view = UIImageView()
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        view.image = img
        return view
    }
    static func txtField(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, placeHolder: String?) -> UITextField {
        let view = UITextField()
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        let attributedPlaceholder = NSAttributedString(string: placeHolder ?? "", attributes: [NSAttributedStringKey.paragraphStyle: centeredParagraphStyle, NSAttributedStringKey.font: UIFont(name: "NanumSquareRoundL", size: 17) ?? UIFont.systemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: UIColor(rgb: 0x949494)])
        view.attributedPlaceholder = attributedPlaceholder
        return view
    }
    static func collection(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, cell: AnyClass, reuseIdentifier: String) -> UICollectionView {
        let view = UICollectionView(frame: CGRect(x: x, y: y, width: width, height: height), collectionViewLayout: UICollectionViewFlowLayout())
        view.register(cell, forCellWithReuseIdentifier: reuseIdentifier)
        return view
    }
}
