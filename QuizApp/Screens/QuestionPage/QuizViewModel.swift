//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Ana on 12/16/24.
//

import Foundation

protocol QuizViewModelDelegate: AnyObject {
    func didUpdateQuestion()
    func didCompleteQuiz(withScore points: Int)
    func didSelectAnswer(at index: Int, isCorrect: Bool)
    func didUpdateNextButtonTitle(_ title: String)
}

final class QuizViewModel {
    // MARK: - Properties
    private let subject: Subject
    let userName: String
    private let dataCommunication: DataCommunication
    
    private(set) var currentQuestionIndex = 0
    private(set) var points = 0
    private(set) var selectedAnswerIndex: Int?
    
    weak var delegate: QuizViewModelDelegate?
    
    var currentQuestion: Question {
        subject.questions[currentQuestionIndex]
    }
    
    var questionProgress: (current: Int, total: Int) {
        (currentQuestionIndex + 1, subject.quizQuestionCount)
    }
    
    var subjectTitle: String {
        subject.subjectTitle
    }
    
    var numberOfOptions: Int {
        currentQuestion.options.count
    }
    
    var isLastQuestion: Bool {
        currentQuestionIndex == subject.questions.count - 1
    }
    
    // MARK: - Initialization
    init(subject: Subject, userName: String, dataCommunication: DataCommunication = .shared) {
        self.subject = subject
        self.userName = userName
        self.dataCommunication = dataCommunication
        updateNextButtonTitle()
    }
    
    // MARK: - Public Methods
    func getOptionTitle(at index: Int) -> String {
        currentQuestion.options[index].title
    }
    
    func selectAnswer(at index: Int) {
        guard selectedAnswerIndex == nil else { return }
        
        selectedAnswerIndex = index
        let selectedOption = currentQuestion.options[index]
        
        if selectedOption.isCorrect {
            points += 1
        }
        
        delegate?.didSelectAnswer(at: index, isCorrect: selectedOption.isCorrect)
    }
    
    func moveToNextQuestion() {
        guard !isLastQuestion else {
            completeQuiz()
            return
        }
        
        currentQuestionIndex += 1
        selectedAnswerIndex = nil
        updateNextButtonTitle()
        delegate?.didUpdateQuestion()
    }
    
    func isOptionCorrect(at index: Int) -> Bool {
        currentQuestion.options[index].isCorrect
    }
    
    func getCorrectAnswerIndex() -> Int? {
        currentQuestion.options.firstIndex(where: { $0.isCorrect })
    }
    
    // MARK: - Private Methods
    private func updateNextButtonTitle() {
        let title = isLastQuestion ? "დასრულება" : "შემდეგი"
        delegate?.didUpdateNextButtonTitle(title)
    }
    
    private func completeQuiz() {
        delegate?.didCompleteQuiz(withScore: points)
        
        Task {
            do {
                let scorePercentage = calculateScorePercentage()
                
                let highestScore = try await dataCommunication.getHighestScore(for: userName, subject: subject.subjectTitle)
                
                if scorePercentage > highestScore {
                    try await dataCommunication.updateUserScore(
                        for: userName,
                        subject: subject.subjectTitle,
                        score: scorePercentage
                    )
                    print("New highest score \(scorePercentage)% saved for \(userName)")
                } else {
                    print("Score \(scorePercentage)% not saved as it's not higher than the highest score (\(highestScore)%)")
                }
            } catch {
                print("Failed to fetch or save score: \(error)")
            }
        }
    }

    private func calculateScorePercentage() -> Int {
        Int((Double(points) / Double(subject.quizQuestionCount)) * 100)
    }
}
