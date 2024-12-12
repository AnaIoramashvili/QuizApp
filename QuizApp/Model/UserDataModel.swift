//
//  UserDataModel.swift
//  QuizApp
//
//  Created by Ana on 12/12/24.
//

import CoreData

// MARK: - UserDataModel
    @objc(UserDataModel)
public class UserDataModel: NSManagedObject {
    @NSManaged public var name: String?
    @NSManaged public var subject: [String: Int]!
}

// MARK: - Fetch Request
extension UserDataModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDataModel> {
        return NSFetchRequest<UserDataModel>(entityName: "UserDataModel")
    }
}   
