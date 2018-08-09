//
//  KeyboardFunc.swift
//  The Genius
//
//  Created by JunsangYu on 09/08/2018.
//  Copyright © 2018 votoserver. All rights reserved.
//

import Foundation
import UIKit

class KeyboardFunc {
    var keyboardShown: Bool = false
    
    func registerForKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        //키보드 올라갔을때
        print("Keyboard Will Show")
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        //키보드 내려갔을때
        print("Keyboard Will Hide")
    }
}
