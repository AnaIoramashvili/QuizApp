//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Ana on 11/26/24.
//

import UIKit

final class QuizViewController: UIViewController {
    
    // MARK: - Properties
    private let headerView = QuizHeaderView()
    private let progressView = QuizProgressView()
    private let questionView = QuizQuestionView()
    
    private lazy var answersTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            AnswerCell.self,
            forCellReuseIdentifier: AnswerCell.identifier
        )
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var nextButton: CustomButton = {
        let button = CustomButton(
            title: Constants.QuizViewControllerConstants.nextButtonTitle,
            height: Constants.QuizViewControllerConstants.nextButtonHeight
        )
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = Constants.QuizViewControllerConstants.nextButtonRadius
        return button
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(
            arrangedSubviews: [
                headerView,
                progressView,
                questionView
            ]
        )
        stack.axis = .vertical
        stack.spacing = Constants.QuizViewControllerConstants.mainStackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setupView()
        setUpHierarchy()
        setUpConstraints()
        configureViews()
    }
    
    private func setupView() {
        view.backgroundColor = Constants.Colors.neutralWhite
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpHierarchy() {
        view.addSubviews(
            mainStackView,
            answersTableView,
            nextButton
           )
    }
    
    // MARK: - Setup
    private func setUpConstraints() {
        setupMainStackViewlConstraints()
        setupAnswersTableViewConstraints()
        setupNextButtonConstraints()
    }

    // MARK: - Constraint Setup Methods
    private func setupMainStackViewlConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.QuizViewControllerConstants.mainStackViewTopPadding
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.QuizViewControllerConstants.mainStackViewHorizontalPadding
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.QuizViewControllerConstants.mainStackViewHorizontalPadding
            ),
        ])
    }

    private func setupAnswersTableViewConstraints() {
        NSLayoutConstraint.activate([
            answersTableView.topAnchor.constraint(
                equalTo: mainStackView.bottomAnchor,
                constant: Constants.QuizViewControllerConstants.answersTableViewTopPadding
            ),
            answersTableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.QuizViewControllerConstants.answersTableViewHorizontalPadding
            ),
            answersTableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.QuizViewControllerConstants.answersTableViewHorizontalPadding
            ),
            answersTableView.heightAnchor.constraint(
                equalToConstant: Constants.QuizViewControllerConstants.answersTableViewHeight
            ),
        ])
    }

    private func setupNextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(
                equalTo: answersTableView.bottomAnchor,
                constant: Constants.QuizViewControllerConstants.nextButtonTopPadding
            ),
            nextButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.QuizViewControllerConstants.nextButtonHorizontalPadding
            ),
            nextButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.QuizViewControllerConstants.nextButtonHorizontalPadding
            ),
        ])
    }
    
    // MARK: - Configure Views
    private func configureViews() {
        headerView.configure(with: "პროგრამირება")
        progressView.updateProgress(currentQuestion: 1, totalQuestions: 10)
        progressView.updatePoints(points: 1)
        questionView.configure(question: "რომელია ყველაზე პოპულარული პროგრამირების ენა?")
    }
    
    // Sample data
    private var answers = ["Python", "Java", "C++", "Kotlin"]
    private var selectedAnswerIndex: Int?
    private var correctAnswerIndex = 1
    
    // MARK: - Actions
    @objc private func nextButtonTapped() {
        
    }
}

// MARK: - UITableViewDataSource
extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as? AnswerCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: answers[indexPath.row])
        
        if let selectedIndex = selectedAnswerIndex, selectedIndex == indexPath.row {
            let isCorrect = indexPath.row == correctAnswerIndex
            cell.updateState(isCorrect: isCorrect)
        } else {
            cell.resetState()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.QuizViewControllerConstants.heightForRow
    }
}

// MARK: - UITableViewDelegate
extension QuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAnswerIndex = indexPath.row
        tableView.reloadData()
    }
}
