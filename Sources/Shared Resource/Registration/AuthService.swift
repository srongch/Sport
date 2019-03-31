//
//  AuthService.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 30/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase

final class AuthService {
  func signInWith(email:String, password:String,handler:@escaping (_ error : Bool?) -> Void){
       Auth.auth().signIn(withEmail: email, password: password, completion: { (result, error) in
//        handler(result?.user,error)
        
        if let error = error {
            handler(false)
            return
        }
        
        UserService.shared.getUser(userID: (result?.user.uid)!,email : email){ user in
            UserService.shared.addUser(user:user, completionHandler: { error1 in
                handler(false)
            })
        }
        
       })
    }
    
    func signUpWith(email : String, password: String, name : String, userType : UserType, handler:@escaping (_ user : User?, _ error : Bool, _ errorMsg : String? ) -> Void){
        Auth.auth().createUser(withEmail: email, password: password, completion
            : { (result, error) in
                if error != nil {
                 //   print("\(error?.localizedDescription)")
                    handler(result?.user, true,nil)
                    return
                }
//                localizedDescription
                let user = CustomUser(name : name, profile : "", uid : result?.user.uid ?? "",email:email, userType: userType)
//                user.
                UserService.shared.addUser(user:user, completionHandler: { error1 in
                    handler(result?.user,false,error?.localizedDescription)
                })
                
        }
        )
    }
    
    func signOut(handler:@escaping (_ error : Bool) -> Void){
        do {
            try Auth.auth().signOut()
            UserService.shared.globalUser = nil
            handler(true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            handler(false)
        }
    }
    
}
