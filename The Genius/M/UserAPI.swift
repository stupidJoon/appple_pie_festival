//
//  UserAPI.swift
//  The Genius
//
//  Created by 이창현 on 2018. 8. 7..
//  Copyright © 2018년 votoserver. All rights reserved.
//

import Foundation

class UserAPI {
    
    var REF_USERS = ("user")
    
    var CURRENT_USER: FIRUser? {
        if let currentUser = FIRAuth.auth()?.currentUser {
            return currentUser
        }
        return nil
    }
    
    var CURRENT_USER_ID = FIRAuth.auth()?.currentUser?.uid
    
    var REF_CURRENT_USER: FIRDatabaseReference? {
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            return nil
        }
        return REF_USERS.child(currentUser.uid)
    }
    
    func observeCurrentUser(completion: @escaping (User) -> Void) {
        guard let currentUser = FIRAuth.auth()?.currentUser else {
            return
        }
        
        REF_USERS.child(currentUser.uid).observeSingleEvent(of: .value, with: { snapshot in
            if let postDictionary = snapshot.value as? [String: Any] {
                let user = User.transformUser(postDictionary: postDictionary)
                completion(user)
            }
        })
    }
    
    func observeUser(withID uid:String, completion: @escaping (User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value, with: { snapshot in
            if let postDictionary = snapshot.value as? [String: Any] {
                let user = User.transformUser(postDictionary: postDictionary)
                completion(user)
            }
        })
    }
    
}
