//
//  UserService.swift
//  User
//
//  Created by Chhem Sronglong on 28/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

import Firebase

final class UserService {
    
    static let shared: UserService = UserService()
    var globalUser : User?
    
    var isHaveUser: Bool {
        get {
            guard (globalUser?.uid != nil) else {
                return false
            }
            
            return true
        }
    }
    
    private init() { }
    
    // MARK: - Firebase Database References
    
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    
    let USER_DB_REF: DatabaseReference = Database.database().reference().child("users")
    
    func addUser(user : User,completionHandler: @escaping (_ isError : Bool) -> Void) {
        let userID = user.uid
        USER_DB_REF.child(userID).setValue(["email" :user.email,"uid" : user.uid]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                completionHandler(true)
            } else {
                print("Data saved successfully!")
                completionHandler(false)
            }
        }
    }
}
