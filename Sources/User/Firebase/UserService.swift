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
    var globalUser : UserProtocol?
    
    var isHaveUser: Bool {
        get {
            guard (globalUser?.uid != nil) else {
                return false
            }
            
            return true
        }
    }
    
    private init() {
        
    }
    
    // MARK: - Firebase Database References
    lazy var functions = Functions.functions()
    
    let BASE_DB_REF: DatabaseReference = Database.database().reference()
    
    let USER_DB_REF: DatabaseReference = Database.database().reference().child("users")
    
    func addUser(user : UserProtocol,completionHandler: @escaping (_ isError : Bool) -> Void) {
        let userID = user.uid
        USER_DB_REF.child(userID).setValue(["email" :user.email,
                                            "uid" : user.uid,
                                            "name": user.name,
                                            "userType" :user.userType.rawValue,
                                            "profile" : user.profile,
                                            "memo" : user.memo]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
                completionHandler(true)
                
            } else {
                print("Data saved successfully!")
                self.globalUser = user
                completionHandler(false)
            }
        }
    }
    
    func editUser(user : UserProtocol,image: Data?,completionHandler: @escaping (_ isError : Bool) -> Void) {
        let userID = user.uid
        
        guard let tempImage = image else{
            self.addUser(user: user) { isError in
                completionHandler(isError)
            }
            return
        }
        
        UploadTask.init().uploadImage(dataArray: [tempImage]) { imageStrings in
            print("\(imageStrings)")
            var model = user
            model.profile = imageStrings[0]
            self.addUser(user: model) { isError in
                completionHandler(isError)
            }
        }
//
//        self.addUser(user: user) { isError in
//            completionHandler(isError)
//        }
//
        
        
        
//        USER_DB_REF.child(userID).setValue(["email" :user.email,
//                                            "uid" : user.uid,
//                                            "name": user.name,
//                                            "userType" :user.userType.rawValue,
//                                            "profile" : user.profile]) {
//                                                (error:Error?, ref:DatabaseReference) in
//                                                if let error = error {
//                                                    print("Data could not be saved: \(error).")
//                                                    completionHandler(true)
//
//                                                } else {
//                                                    print("Data saved successfully!")
//                                                    self.globalUser = user
//                                                    completionHandler(false)
//                                                }
//        }
    }
    
    func getUser(userID : String,email : String, completionHandler: @escaping (_ user : UserProtocol) -> Void) {
        
        functions.httpsCallable("ping").call() { (result, error) in
            if (error != nil){
                if let user = CustomUser.loadFromDisk(){
                    self.globalUser = user
                    completionHandler(user)
                }else{
                    completionHandler(CustomUser(name: "Jonh Deo", profile: "", uid: userID, email:email , userType: .user))
                }
                
            }else{
                self.USER_DB_REF.child(userID).observeSingleEvent(of: .value) { (snapshot) in
                    
                    if let user = CustomUser(snapshot: snapshot){
                        completionHandler(user)
                        self.globalUser = user
                        self.globalUser?.saveToDisk()
                        
                        return
                    }else{
                        completionHandler(CustomUser(name: "Jonh Deo", profile: "", uid: userID, email:email , userType: .user))
                        return
                    }
                    
                }
            }
            
            
        }
        
        
    
    }
}
