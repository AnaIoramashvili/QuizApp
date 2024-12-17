//
//  HomePageViewController.swift
//  QuizApp
//
//  Created by Ana on 11/14/24.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    private let viewModel: HomePageViewModel
    private let subjects = MockData.subjects
    
    // MARK: - Properties
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.yellowPrimary
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gpaView: GPAView = {
        let view = GPAView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let subjectsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomePageConstants.chooseSubject
        label.textColor = Constants.Colors.neutralDarkGrey
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SubjectCell.self, forCellReuseIdentifier: SubjectCell.identifier)
        return tableView
    }()
    
    private let bottomSeparatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.neutralLighterGray2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let logOutButton: UIButton = {
        let logOutButton = CustomRoundButton()
        logOutButton.configure(with: UIImage(named: Constants.Images.logOutButton))
        logOutButton.addTarget(self, action: #selector(handleLogOutButtonTap), for: .touchUpInside)
        return logOutButton
    }()
    
    private lazy var popUp: CustomPopUp = {
        let popUp = CustomPopUp()
        popUp.configure(question: Constants.HomePageConstants.logoutQuestion)
        popUp.isHidden = true
        popUp.acceptButtonTap = { [weak self] in
            self?.logOutUser()
        }
        popUp.rejectButtonTap = { [weak self] in
            self?.dismissPopUp()
        }
        return popUp
    }()
    
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(Constants.QuizViewControllerConstants.alphaComponent)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    init(user: UserDataModel) {
        self.viewModel = HomePageViewModel(currentUser: user)
        super.init(nibName: nil, bundle: nil)
        viewModel.setCurrentUser(user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        gpaView.delegate = self
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headerLabel.text = "გამარჯობა, \(viewModel.userName)!"
        gpaView.updateScore(viewModel.calculateGPA)
    }
    
    // MARK: - Setup Methods
    private func setUp() {
        setupView()
        setUpHierarchy()
        setUpConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = Constants.Colors.neutralWhite
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setUpHierarchy() {
        view.addSubviews(
            headerLabel,
            gpaView,
            subjectsLabel,
            tableView,
            bottomSeparatorLine,
            logOutButton,
            dimmedView,
            popUp
        )
    }
    
    private func setUpConstraints() {
        setupHeaderLabelConstraints()
        setupGPAViewConstraints()
        setupSubjectsLabelConstraints()
        setupTableViewConstraints()
        setupBottomSeparatorLineConstraints()
        setupLogOutButtonConstraints()
        setupDimmedViewConstraints()
        setupPopUpConstraints()
    }

    // MARK: - Constraint Setup Methods
    private func setupHeaderLabelConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Constants.HomePageConstants.headerTopPadding
            ),
            headerLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.HomePageConstants.horizontalPadding
            )
        ])
    }

    private func setupGPAViewConstraints() {
        NSLayoutConstraint.activate([
            gpaView.topAnchor.constraint(
                equalTo: headerLabel.bottomAnchor,
                constant: Constants.HomePageConstants.gpaViewTopPadding
            ),
            gpaView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.HomePageConstants.horizontalPadding
            ),
            gpaView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -Constants.HomePageConstants.horizontalPadding
            )
        ])
    }

    private func setupSubjectsLabelConstraints() {
        NSLayoutConstraint.activate([
            subjectsLabel.topAnchor.constraint(
                equalTo: gpaView.bottomAnchor,
                constant: Constants.HomePageConstants.subjectsLabelTopPadding
            ),
            subjectsLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.HomePageConstants.horizontalPadding
            )
        ])
    }

    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: subjectsLabel.bottomAnchor,
                constant: Constants.HomePageConstants.tableViewTopPadding
            ),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomSeparatorLine.topAnchor)
        ])
    }

    private func setupBottomSeparatorLineConstraints() {
        NSLayoutConstraint.activate([
            bottomSeparatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSeparatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSeparatorLine.heightAnchor.constraint(
                equalToConstant: Constants.HomePageConstants.bottomSeparatorLine
            ),
            bottomSeparatorLine.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Constants.HomePageConstants.bottomSeparatorLinePadding
            )
        ])
    }

    private func setupLogOutButtonConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Constants.HomePageConstants.logOutButtonLeadingPadding
            ),
            logOutButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Constants.HomePageConstants.logoutButtonBottomPadding
            ),
            logOutButton.widthAnchor.constraint(equalToConstant: Constants.HomePageConstants.logoutButtonWidth),
            logOutButton.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.logoutButtonHeight)
        ])
    }
    
    private func setupPopUpConstraints() {
        NSLayoutConstraint.activate([
            popUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUp.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUp.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: Constants.HomePageConstants.popUpWidth),
            popUp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.HomePageConstants.popUpHeight)
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
    
    // MARK: - Button Actions
    @objc private func handleLogOutButtonTap() {
        showPopUp()
    }
    
    private func showPopUp() {
        dimmedView.isHidden = false
        popUp.isHidden = false
    }

    private func dismissPopUp() {
        dimmedView.isHidden = true
        popUp.isHidden = true
    }
    
    private func logOutUser() {
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SubjectCell.identifier,
            for: indexPath
        ) as? SubjectCell else {
            return UITableViewCell()
        }
        
        let subject = subjects[indexPath.row]
        cell.configure(with: subject)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSubject = subjects[indexPath.row]
        let quizVC = QuizViewController(
            subject: selectedSubject,
            userName: viewModel.userName
        )
        quizVC.delegate = self
        navigationController?.pushViewController(quizVC, animated: true)
    }
}

extension HomePageViewController: QuizViewControllerDelegate {
    func quizViewControllerDidFinish(_ controller: QuizViewController, with user: UserDataModel) {
        viewModel.setCurrentUser(user)
        headerLabel.text = "გამარჯობა, \(viewModel.userName)!"
        gpaView.updateScore(viewModel.calculateGPA)
    }
}

extension HomePageViewController: GPAViewDelegate {
    func didTapDetailsButton() {
        let scoreVC = ScorePageViewController(userName: viewModel.userName)
        navigationController?.pushViewController(scoreVC, animated: true)
    }
}
