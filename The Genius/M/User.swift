//
//  User.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation

struct User {
    var user_token: String
    var user_name: String
    var setting: Bool
    var die: Bool
    var now_room: String
    var game_data:GameData
}

class GameData {
    var name: String
    var pay:String
    var pay_number:Int
    var department:String
    var win_condition: Array<Any>
    var lose_condition: String
    var uniqueness: String
    
}
