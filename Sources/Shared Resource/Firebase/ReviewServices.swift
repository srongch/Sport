//
//  ReviewServices.swift
//  SportSharing
//
//  Created by Chhem Sronglong on 22/04/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase

final class ReviewServices {
    //
    
    lazy var classesRef: DatabaseReference = {
        return Database.database().reference(withPath: "reviews")
    }()
    
    lazy var functions = Functions.functions()
    
    init (){}
    
    func getReview(classId : String, completionHandler: @escaping (_ model:  [ReviewModel]?) -> Void) {
        functions.httpsCallable("classReviews").call(["classId": classId]) { (result, error) in
            // [START function_error]
            if let error = error as NSError? {
                if error.domain == FunctionsErrorDomain {
                    let code = FunctionsErrorCode(rawValue: error.code)
                    let message = error.localizedDescription
                    let details = error.userInfo[FunctionsErrorDetailsKey]
                }
                // [START_EXCLUDE]
                print(error.localizedDescription)
                return completionHandler(nil)
                // [END_EXCLUDE]
            }
            // [END function_error]
            guard let value = (result?.data as? [String: AnyObject]),
               let reviews = value["data"] as? Dictionary<String, AnyObject> else{
                    completionHandler(nil)
                    return
            }
            
            let reviewArray = ReviewModel.getReviews(data: reviews ).sorted(by: {$0.timeStamp > $1.timeStamp})
            
            return completionHandler(reviewArray)
            
        }
    }
    
}

