//
//  User.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var user_token: String
    var user_name: String
    var setting: Bool
    var die: Bool
    var now_room: String
    var game_data: GameData
}

extension User {
    static func transformUser(temp:JSON) -> User? {
        let json = temp["data"]
        
        let game_data = json["game_data"]
        
        let user = User(
            user_token: json["user_token"].stringValue,
            user_name: json["user_name"].stringValue,
            setting: json["setting"].boolValue,
            die: json["die"].boolValue,
            now_room: json["now_room"].stringValue,
            game_data:
            GameData(name: game_data["name"].stringValue,
                     pay: game_data["pay"].stringValue,
                     pay_number: game_data["pay_number"].intValue,
                     department: game_data["department"].stringValue,
                     win_condition: game_data["win_condition"].arrayValue.map{$0.stringValue},
                     lose_condition: game_data["lose_condition"].stringValue,
                     uniqueness: game_data["uniqueness"].arrayValue.map{$0.stringValue},
                     rank: game_data["rank"].intValue,
                     profile: game_data["profile"].stringValue,
                     card: game_data["card"].stringValue))
        
        return user
    }
}

struct GameData {
    ///유저 역할
    var name: String
    var pay:String
    var pay_number:Int
    var department:String
    var win_condition: Array<String>
    var lose_condition: String
    var uniqueness: Array<String>
    var rank: Int
    var profile: String
    var card: String
}
