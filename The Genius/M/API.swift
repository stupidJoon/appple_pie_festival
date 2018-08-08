//
//  API.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation


struct API {
    static var base_url = "http://aws.soylatte.kr:5000"
    static var User = UserAPI()
    static var currentUser:User?
}
