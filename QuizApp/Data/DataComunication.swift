//
//  DataComunication.swift
//  QuizApp
//
//  Created by Ana on 12/12/24.
//

import CoreData
import UIKit

enum DataCommunicationError: Error {
    case userAlreadyExists
    case failedToSaveUser
    case userNotFound
    case subjectNotFound
}

// MARK: - DataCommunication
final class DataCommunication {
    static let shared = DataCommunication()
    private let container: NSPersistentContainer
    
    private init() {
        container = (UIApplication.shared.delegate as! AppDelegate).container
    }
    
    // MARK: - User Management
    func loginUser(with name: String) async throws -> UserDataModel {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<UserDataModel> = UserDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let existingUsers = try context.fetch(fetchRequest)
        
        if let existingUser = existingUsers.first {
            print("User '\(name)' found in database")
            return existingUser
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "UserDataModel", in: context) else {
            throw DataCommunicationError.failedToSaveUser
        }
        
        let newUser = UserDataModel(entity: entity, insertInto: context)
        newUser.name = name
        newUser.subject = [:]
        
        do {
            try context.save()
            print("New user '\(name)' successfully created and saved")
            return newUser
        } catch {
            print("Failed to save user: \(error)")
            throw DataCommunicationError.failedToSaveUser
        }
    }
    
    func updateUserScore(for name: String, subject: String, score: Int) async throws {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<UserDataModel> = UserDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        guard let user = try context.fetch(fetchRequest).first else {
            throw DataCommunicationError.userNotFound
        }
        
        var subjects = user.subject ?? [:]
        let currentHighestScore = subjects[subject] ?? 0
        
        if score > currentHighestScore {
            subjects[subject] = score
            user.subject = subjects
            
            try context.save()
            print("Score updated for user '\(name)': \(subject) = \(score)")
        } else {
            print("New score \(score) is not higher than the current highest score (\(currentHighestScore)) for \(subject). Score not updated.")
        }
    }
    
    func getHighestScore(for name: String, subject: String) async throws -> Int {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<UserDataModel> = UserDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        guard let user = try context.fetch(fetchRequest).first else {
            throw DataCommunicationError.userNotFound
        }
        
        let subjects = user.subject ?? [:]
        return subjects[subject] ?? 0
    }
    
    func getUser(by name: String) async throws -> UserDataModel? {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<UserDataModel> = UserDataModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        let users = try context.fetch(fetchRequest)
        
        if let user = users.first {
            print("Successfully fetched user: \(name)")
            return user
        } else {
            print("User not found: \(name)")
            throw DataCommunicationError.userNotFound
        }
    }
}
