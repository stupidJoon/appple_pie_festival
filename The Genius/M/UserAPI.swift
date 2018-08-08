//
//  UserAPI.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI {
    func fetch(withToken:String = "5vEim7ehKyW2LvW8hJuCGDwmOcSSu4tZ",completion:@escaping(User?,Int) -> Void) {
        Alamofire.request("\(API.base_url)/game/data/\(withToken)")
            .responseJSON(completionHandler: { (response) in
                
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    let json = JSON(value)
                    
                    let status:Int = json["status"].intValue
                    
                    let user:User? = User.transformUser(temp: json)
                    completion(user,status)
                }
            })
    }
    
    func set(withUser: User) {
        API.currentUser = withUser
    }
}
