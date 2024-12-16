//
//  QuizViewController.swift
//  QuizApp
//
//  Created by Ana on 11/26/24.
//

import UIKit

protocol QuizViewControllerDelegate: AnyObject {
    func quizViewControllerDidFinish(_ controller: QuizViewController, with user: UserDataModel)
}

final class QuizViewController: UIViewController, QuizHeaderViewDelegate {
    
    weak var delegate: QuizViewControllerDelegate?
    
    // MARK: - Properties
    private let viewModel: QuizViewModel
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
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = Constants.QuizViewControllerConstants.mainStackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scorePopUp: ScorePopUp = {
        let popUp = ScorePopUp()
        popUp.closeAction = { [weak self] in
            self?.navigateToHome()
        }
        popUp.translatesAutoresizingMaskIntoConstraints = false
        return popUp
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(Constants.QuizViewControllerConstants.alphaComponent)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialization
    init(subject: Subject, userName: String) {
        self.viewModel = QuizViewModel(subject: subject, userName: userName)
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        mainStackView.addArrangedSubviews(
            headerView,
            progressView,
            questionView
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
            )
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
            )
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
            )
        ])
    }
    
    private func setupDimmedViewConstraints() {
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration Methods
    private func configureViews() {
        let progress = viewModel.questionProgress
        
        headerView.configure(with: viewModel.subjectTitle)
        progressView.updateProgress(
            currentQuestion: progress.current,
            totalQuestions: progress.total
        )
        progressView.updatePoints(points: viewModel.points)
        questionView.configure(question: viewModel.currentQuestion.title)
        answersTableView.reloadData()
        
        headerView.delegate = self
    }
    
    // MARK: - Navigation Methods
    private func navigateToHome() {
        Task {
            do {
                if let user = try await DataCommunication.shared.getUser(by: viewModel.userName) {
                    delegate?.quizViewControllerDidFinish(self, with: user)
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            } catch {
                print("Error fetching user data: \(error)")
            }
        }
    }
    
    private func showResults() {
        view.addSubview(dimmedView)
        view.addSubview(scorePopUp)
        setupDimmedViewConstraints()
        
        NSLayoutConstraint.activate([
            scorePopUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scorePopUp.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scorePopUp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.QuizViewControllerConstants.scorepopUpWidth),
            scorePopUp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.QuizViewControllerConstants.scorepopUpHeight)
        ])
        
        scorePopUp.configure(points: viewModel.points)
    }
    
    private func showQuitConfirmationPopup() {
        let quitPopup = CustomPopUp()
        quitPopup.configure(question: Constants.QuizViewControllerConstants.quitQuizText)
        
        quitPopup.acceptButtonTap = { [weak self] in
            self?.dimmedView.removeFromSuperview()
            self?.navigateToHome()
        }
        
        quitPopup.rejectButtonTap = { [weak quitPopup] in
            quitPopup?.removeFromSuperview()
            self.dimmedView.removeFromSuperview() 
        }
        
        view.addSubview(dimmedView)
        setupDimmedViewConstraints()
        view.addSubview(quitPopup)
        quitPopup.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quitPopup.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            quitPopup.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quitPopup.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.QuizViewControllerConstants.quitpopUpWidth),
            quitPopup.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.QuizViewControllerConstants.quitpopUpHeight)
        ])
    }
    
    // MARK: - QuizHeaderViewDelegate
    func didTapCloseButton() {
        showQuitConfirmationPopup()
    }
    
    // MARK: - Actions
    @objc private func nextButtonTapped() {
        viewModel.moveToNextQuestion()
    }
}

// MARK: - UITableViewDataSource
extension QuizViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfOptions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AnswerCell.identifier,
            for: indexPath
        ) as? AnswerCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.getOptionTitle(at: indexPath.row))
        
        if let selectedIndex = viewModel.selectedAnswerIndex {
            if selectedIndex == indexPath.row {
                cell.updateState(isCorrect: viewModel.isOptionCorrect(at: indexPath.row))
            } else if viewModel.isOptionCorrect(at: indexPath.row) {
                cell.markAsCorrect()
            } else {
                cell.resetState()
            }
        } else {
            cell.resetState()
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension QuizViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectAnswer(at: indexPath.row)
    }
}

// MARK: - QuizViewModelDelegate
extension QuizViewController: QuizViewModelDelegate {
    func didUpdateQuestion() {
        answersTableView.allowsSelection = true
        configureViews()
    }
    
    func didCompleteQuiz(withScore points: Int) {
        showResults()
    }
    
    func didSelectAnswer(at index: Int, isCorrect: Bool) {
        progressView.updatePoints(points: viewModel.points)
        answersTableView.reloadData()
        answersTableView.allowsSelection = false
    }
    
    func didUpdateNextButtonTitle(_ title: String) {
        nextButton.setTitle(title, for: .normal)
    }
}
