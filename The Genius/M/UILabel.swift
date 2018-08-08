//
//  UILabel.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 8..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    func append(_ string:String?) {
        let newText = self.text! + (string ?? "")
        self.text = newText
    }
}
