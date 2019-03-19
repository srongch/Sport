//
//  AddClassViewModel.swift
//  Trainer
//
//  Created by Chhem Sronglong on 16/03/2019.
//  Copyright © 2019 100456065. All rights reserved.
//

import Foundation

class AddClassViewModel {
    var classModel : ClassModel?
    var about : String {
        set (newAbout) {
            classModel?.classAbout = newAbout
        }
        get{
            return classModel?.classAbout ?? ""
        }
    }
    
    var timeTable : String {
        set (newTimeTable) {
            classModel?.timeTable = newTimeTable
        }
        get{
            return classModel?.timeTable ?? ""
        }
    }

    var equipment : String {
        set (newEquipment) {
            classModel?.equipment = newEquipment
        }
        get{
            return classModel?.equipment ?? ""
        }
    }
    
    var startDate : Date {
        set (newStartDate) {
            classModel?.startDate = newStartDate
        }
        get {
            return classModel?.startDate ?? Date()
        }
    }
    
    var endDate : Date {
        set (newEndDate) {
            classModel?.endDate = newEndDate
        }
        get {
            return classModel?.endDate ?? Date()
        }
    }
    
    var hour : [Int] {
        set (new) {
            classModel?.hours = new
        }
        get {
            return classModel?.hours ?? []
        }
    }

    init(classModel : ClassModel) {
        self.classModel = classModel
    }
    

    func getFirebaseObjeft() -> ([Data],FirebaseClassModel){
        
        guard let tempModel = classModel else {
            return ([],FirebaseClassModel())
        }
    
        var firebasemodel = FirebaseClassModel(classModel: tempModel)
        firebasemodel.startDate = tempModel.startDate!.toMillis()
        firebasemodel.endDate = tempModel.endDate!.toMillis()
        firebasemodel.dayoftheWeek = Array(tempModel.dayoftheWeek)
        firebasemodel.hours = tempModel.hours
        firebasemodel.times = tempModel.times.map( {value in value.toMillis()})
        
        return (tempModel.imageArray.map({$0.jpegData(compressionQuality: 0.9)!}),firebasemodel)
        
//          need to setup the follow
//        var startDate : Double = 0 // timestap
//        var endDate : Double = 0 //timestap
//        var dayoftheWeek :  [Int] = []
//        var hours : [Int] = []
//        var times : [Double] = [] //timestamp
//        var imageArray: [String] = []
        
    }
    
    

    
}
