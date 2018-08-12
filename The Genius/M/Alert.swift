//
//  Alert.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 10..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func show_alert(with:String) {
        let alert = UIAlertController(title: "알림", message: with, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
