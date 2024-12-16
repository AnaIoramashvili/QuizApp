//
//  HomePageViewModel.swift
//  QuizApp
//
//  Created by Ana on 12/16/24.
//

import Foundation

final class HomePageViewModel {
    private let dataCommunication = DataCommunication.shared
    private var currentUser: UserDataModel?
    
    var userName: String {
        return currentUser?.name ?? "User"
    }
    
    var subjects: [String: Int] {
        return currentUser?.subject ?? [:]
    }
    
    func setCurrentUser(_ user: UserDataModel) {
        self.currentUser = user
        print("👤 Current user set to: \(user.name ?? "Unknown")")
    }
    
    func updateScore(for subject: String, score: Int) async -> Result<Void, DataCommunicationError> {
        guard let userName = currentUser?.name else {
            return .failure(.userNotFound)
        }
        
        do {
            try await dataCommunication.updateUserScore(for: userName, subject: subject, score: score)
            return .success(())
        } catch {
            return .failure(error as? DataCommunicationError ?? .failedToSaveUser)
        }
    }
    
    var calculateGPA: Double {
        guard let subjects = currentUser?.subject, !subjects.isEmpty else { return 0.0 }
        
        let totalPercentage = subjects.values.reduce(0, +)
        let gpa = Double(totalPercentage) / Double(subjects.count) / 25.0
        return min(gpa, 4.0)
    }}
