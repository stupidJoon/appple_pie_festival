//
//  Light_user.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 9..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation
import SwiftyJSON

///다른 유저 프로필 띄우는 클래스
struct LightUser {
    var user_token: String
    var user_name: String
    var user_profile: String
}

extension LightUser {
    static func transformUser(temp:JSON) -> [LightUser] {
        let json = temp["data"].arrayValue
        
        //아름다운 코드 ㅎㅎ
        let lightuser:[LightUser] = json.map{LightUser(user_token: $0["user_token"].stringValue,
                                                       user_name: $0["user_name"].stringValue,
                                                       user_profile: $0["user_profile"].stringValue)}
        
        
        return lightuser
    }
    
    static func transformUser_inroom(temp:JSON) -> [LightUser] {
        let json = temp["data"]["user_list"].arrayValue
        
        //아름다운 코드 ㅎㅎ
        let lightuser:[LightUser] = json.map{LightUser(user_token: $0["user_token"].stringValue,
                                                       user_name: $0["user_name"].stringValue,
                                                       user_profile: $0["user_profile"].stringValue)}
        
        
        return lightuser
    }
}

