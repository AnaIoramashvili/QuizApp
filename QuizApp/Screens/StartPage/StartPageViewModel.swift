//
//  StartPageViewModel.swift
//  QuizApp
//
//  Created by Ana on 12/12/24.
//

import Foundation

final class StartPageViewModel {
    private let dataCommunication = DataCommunication.shared
    
    func loginUser(with name: String) async -> Result<UserDataModel, DataCommunicationError> {
        do {
            let user = try await dataCommunication.loginUser(with: name)
            return .success(user)
        } catch {
            return .failure(error as? DataCommunicationError ?? .failedToSaveUser)
        }
    }
}
