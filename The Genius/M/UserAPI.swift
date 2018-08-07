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
    func fetchUsers(completion:@escaping(Any?) -> Void) {
        Alamofire.request("http://aws.soylatte.kr:5000/admin/user/list")
            .responseJSON(completionHandler: { (response) in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error: \(String(describing: response.result.error))")
                        completion(nil)
                        return
                }
                //guard에서 오류를 걸러주고
                let tags = JSON(value).array?.map { json in
                    print(json["user_name"].stringValue)
                }
            })
    }
    
}
