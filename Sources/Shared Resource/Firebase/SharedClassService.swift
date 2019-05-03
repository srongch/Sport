//
//  SharedClassService.swift
//  User
//
//  Created by Chhem Sronglong on 23/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase
final class SharedClassService{
    
    lazy var functions = Functions.functions()
    
    func classDetailById(classId : String, authorId : String, completionHandler: @escaping (_ classModel:ClassModel?,_ reviewArry : [ReviewModel]?, _ isError : Bool) -> Void){
        // [START function_add_numbers]
        functions.httpsCallable("getClassById").call(["classId": classId,"authorId" : authorId]) { (result, error) in
            // [START function_error]
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
                // [START_EXCLUDE]
                print(error.localizedDescription)
                return completionHandler(nil,nil,true)
                // [END_EXCLUDE]
            }
            // [END function_error]
            guard let value = (result?.data as? [String: AnyObject]),
                let classes = value["classes"] as?  [String : AnyObject] else{
                    completionHandler(nil,nil,true)
                    return
            }
            
            guard let reviews = value["reviews"] as? Dictionary<String, AnyObject> else {
                completionHandler( ClassModel(value: classes,key: "" ), nil,false)
                return
            }
            
            let reviewArray = ReviewModel.getReviews(data: reviews )
            
            return completionHandler(ClassModel(value: classes,key: "" ),reviewArray,false)
            
            
        }
        // [END function_add_numbers]
    }
}
