//
//  GameAPI.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 10..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GameAPI {
    func fetch_userlist_inroom(withToken:String,completion:@escaping([LightUser],Int) -> Void) {
        Alamofire.request("\(API.base_url)/game/room/member/\(withToken)")
            .responseJSON(completionHandler: { (response) in
                
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    let json = JSON(value)
                    
                    let status:Int = json["status"].intValue
                    
                    let user:[LightUser] = LightUser.transformUser_inroom(temp: json)
                    completion(user,status)
                }
            })
    }
    func fetch_isGameStarted(withToken: String,completion:@escaping(Bool,Int)->Void) {
        Alamofire.request("\(API.base_url)/game/check/start/\(withToken)")
            .responseJSON(completionHandler: { (response) in
                
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    let json = JSON(value)
                    
                    let status:Int = json["status"].intValue
                    
                    let start:Bool = json["start"].boolValue
                    completion(start,status)
                }
            })
        
    }
    
    func move_department(withToken: String,goto: String, completion:@escaping(String,Int)->Void) {
        let headers: HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "user_token": withToken,
            "move_department": goto
        ]
        Alamofire.request("\(API.base_url)/game/move",method:.post,parameters:parameters,encoding:URLEncoding.httpBody,headers:headers)
            .responseJSON(completionHandler: { (response) in
                
                //1. JSON 변환
                if let value = response.result.value,response.result.isSuccess {
                    let json = JSON(value)
                    
                    let status:Int = json["status"].intValue
                    
                    let msg:String = json["message"].stringValue
                    
                    completion(msg,status)
                }
            })
    }
}
