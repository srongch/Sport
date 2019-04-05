//
//  ClassService.swift
//  User
//
//  Created by 100456065 on 19/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation
import Firebase

final class ClassService {
//
    
    lazy var classesRef: DatabaseReference = {
        return Database.database().reference(withPath: "classes")
    }()
    
    lazy var functions = Functions.functions()
//    // MARK: - Firebase Storage Reference
//    let PHOTO_STORAGE_REF: StorageReference = Storage.storage().reference().child("photos")
    
    init (){}

    func getClassById(classId : String, completionHandler: @escaping (_ model:  ClassModel?) -> Void) {
        classesRef.child(classId).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let user = ClassModel(snapshot: snapshot)
            
            completionHandler(user ?? nil)
            // ...
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    
    func getHomeClass(completionHandler: @escaping (_ model:  [ClassModel]?) -> Void) {
        classesRef.queryOrdered(byChild: "rating").queryLimited(toLast: 4).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard ((snapshot.value as? [String:Any]) != nil) else {
                completionHandler(nil)
                return
            }
            
            var model = ClassModel.classModelFromArray(snapshot: snapshot)
            model?.sort(by: {$0.rating > $1.rating})
            completionHandler(model)
            // ...
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    func getClassByActivity(activity : Int ,completionHandler: @escaping (_ model:  [ClassModel]?) -> Void) {
        classesRef.queryOrdered(byChild: "activityType").queryEqual(toValue: activity).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard ((snapshot.value as? [String:Any]) != nil) else {
                completionHandler(nil)
                return
            }
            
            var model = ClassModel.classModelFromArray(snapshot: snapshot)
            model?.sort(by: {$0.timeStamp > $1.timeStamp})
            completionHandler(model)
            // ...
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
    
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
                completionHandler( ClassModel(value: classes ), nil,false)
                return
            }
            
            let reviewArray = ReviewModel.getReviews(data: reviews )
            
             return completionHandler(ClassModel(value: classes ),reviewArray,false)
           
            
        }
        // [END function_add_numbers]
    }
    
    func doBooking(bookingModel : BookingModel, completionHandler: @escaping (_ isError : Bool) -> Void){
        functions.httpsCallable("userBooking").call(bookingModel.asDictionary) { (result, error) in
            print(bookingModel.asDictionary)
            return  completionHandler((error != nil) ? true : false)
        }
    }
    
    
    func bookingList(userId : String, completionHandler: @escaping (_ result : [BookingModel]? ,_ isError : Bool) -> Void){
        functions.httpsCallable("userBookingList").call(["userId" : "98tKelkTBGcaQOG5157Q2Lv5mgm2"]) { (result, error) in
        //    print("\(result?.data )")
            
            if (error != nil){
                print("no nil")
                return  completionHandler(nil, true)
            }
            
//            guard let error1 = error else{
//                return  completionHandler(nil, true)
//            }
//
            guard let value = (result?.data as? [String: AnyObject]),
                  let data = value["data"] as? Dictionary<String, AnyObject> else {
               return  completionHandler(nil, true)
            }
            print("\(data)")
            
            return  completionHandler(BookingModel.getBookingModels(data: data).sorted(by: {$0.timeStamp > $1.timeStamp}),false)
        }
        
    }
    
//    func addLiketoClass
    
//    func addClasses(tuple : ([Data],FirebaseClassModel),completionHandler: @escaping (_ isError : Bool) -> Void) {
//
//        print(tuple.1.asDictionary)
//
//        self.uploadImage(dataArray: tuple.0) { [weak self] (images) in
//
//            var model = tuple.1
//            model.imageArray = images
//            model.timeStamp = Date().toMillis()
//
//            self!.classesRef.childByAutoId().setValue(model.asDictionary) {
//                (error:Error?, ref:DatabaseReference) in
//                if let error = error {
//                    print("Data could not be saved: \(error).")
//                    completionHandler(true)
//                } else {
//                    print("Data saved successfully!")
//                    completionHandler(false)
//                }
//
//            }
//        }
//
//    }
//
//    func uploadImage(dataArray : [Data], completionHandler: @escaping ([String]) -> Void) {
//
//        if (dataArray.count <= 0) {
//            completionHandler([])
//            return
//        }
//
//        var uploadedImageUrlsArray = [String](repeating: "", count: dataArray.count)
//        var uploadCount = 0
//        let imagesCount = dataArray.count
//
//        let imageNameOrder = (1...dataArray.count).map{_ in "\(NSUUID().uuidString).jpg"}
//
//        for n in 0...dataArray.count - 1{
//
//
//            // Use the unique key as the image name and prepare the storage reference
//            let imageName = NSUUID().uuidString // Unique string to reference image
//            print("prepare to upload \(imageName)")
//
//            let imageStorageRef = PHOTO_STORAGE_REF.child("\(imageNameOrder[n])")
//
//            // Create the file metadata
//            let metadata = StorageMetadata()
//            metadata.contentType = "image/jpg"
//
//            // Prepare the upload task
//            let uploadTask = imageStorageRef.putData(dataArray[n], metadata: metadata)
//
//            // Observe the upload status
//            uploadTask.observe(.success) { (snapshot) in
//
//                //            guard let displayName = Auth.auth().currentUser?.displayName else {
//                //                return
//                //            }
//
//                // Add a reference in the database
//                snapshot.reference.downloadURL(completion: { (url, error) in
//                    guard let url = url else {
//                        return
//                    }
//                    // Add a reference in the database
//                    let imageFileURL = url.absoluteString
//                    let filename = snapshot.metadata?.name
//                    let indexofName = imageNameOrder.firstIndex(of: filename ?? imageNameOrder.first!)
//                    print("found at index \(indexofName) with name : \(filename)")
//                    uploadedImageUrlsArray[indexofName!] = imageFileURL
//
//                    uploadCount += 1
//                    //  print("Number of images successfully uploaded: \(uploadCount)")
//                    // print("the image of metatadata : \(snapshot.metadata?.name ?? "") upload compelete")
//                    if uploadCount == imagesCount{
//                        //   NSLog("All Images are uploaded successfully, uploadedImageUrlsArray: \(uploadedImageUrlsArray)")
//                        print("image order : \(imageNameOrder)")
//                        print("upload oder : \(uploadedImageUrlsArray)")
//                        completionHandler(uploadedImageUrlsArray)
//                    }
//
//                })
//            }
//
//            uploadTask.observe(.progress) { (snapshot) in
//
//                let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
//                print("Uploading... \(percentComplete)% complete")
//            }
//
//            uploadTask.observe(.failure) { (snapshot) in
//
//                if let error = snapshot.error {
//                    print(error.localizedDescription)
//                }
//            }
//        }
//    }
}

