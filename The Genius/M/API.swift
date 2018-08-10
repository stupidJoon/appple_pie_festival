//
//  API.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation
import UIKit

var current_token: String {
    return API.currentUser?.user_token ?? ""
}

struct API {
    static var base_url = "http://aws.soylatte.kr:3000"
    static var User = UserAPI()
    static var Game = GameAPI()
    static var currentUser:User?
    static var otherUsers:[LightUser] = []
}

extension UIViewController {
    func goto(VC:UIViewController) {
        self.present(VC, animated: true, completion: {
            return
        })
    }
}
