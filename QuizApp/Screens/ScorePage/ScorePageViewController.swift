//
//  ScorePageViewController.swift
//  QuizApp
//
//  Created by Ana on 11/28/24.
//

import UIKit

final class ScorePageViewController: UIViewController {
    
    // MARK: - Properties
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .createHeaderText()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = .createEmptyStateText()
        label.numberOfLines = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SubjectCell.self, forCellReuseIdentifier: SubjectCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let backButton: UIButton = {
        let backButton = UIButton()
        backButton.setImage(UIImage(named: "backButton"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        return backButton
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
        return logOutButton
    }()
    
    private var subjectsWithScores: [(subject: Subject, score: Int)] = [] {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
            tableView,
            emptyStateLabel,
            backButton,
            bottomSeparatorLine,
            logOutButton
        )
    }
    
    private func setUpConstraints() {
        setUpHeaderConstraints()
        setUpBackButtonConstraints()
        setUpTableViewConstraints()
        setUpEmptyStateLabelConstraints()
        setUpBottomSeparatorConstraints()
        setUpLogOutButtonConstraints()
    }
    
    private func setUpHeaderConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Layout.Header.topPadding
            ),
            headerLabel.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Layout.Header.leadingPadding
            )
        ])
    }
    
    private func setUpBackButtonConstraints() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Layout.BackButton.leadingPadding
            ),
            backButton.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: Layout.BackButton.topPadding
            ),
            backButton.widthAnchor.constraint(equalToConstant: Layout.BackButton.width),
            backButton.heightAnchor.constraint(equalToConstant: Layout.BackButton.height)
        ])
    }
    
    private func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: headerLabel.bottomAnchor,
                constant: Layout.TableView.topPadding
            ),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setUpEmptyStateLabelConstraints() {
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setUpBottomSeparatorConstraints() {
        NSLayoutConstraint.activate([
            bottomSeparatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSeparatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSeparatorLine.heightAnchor.constraint(
                equalToConstant: Layout.BottomSeparator.height
            ),
            bottomSeparatorLine.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Layout.BottomSeparator.bottomPadding
            )
        ])
    }
    
    private func setUpLogOutButtonConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: Layout.LogOutButton.leadingPadding
            ),
            logOutButton.bottomAnchor.constraint(
                equalTo: view.bottomAnchor,
                constant: Layout.LogOutButton.bottomPadding
            ),
            logOutButton.widthAnchor.constraint(equalToConstant: Layout.LogOutButton.width),
            logOutButton.heightAnchor.constraint(equalToConstant: Layout.LogOutButton.height)
        ])
    }
    
    // MARK: - Private Methods
    private func updateUI() {
        let hasScores = subjectsWithScores.contains { $0.score > 0 }
        emptyStateLabel.isHidden = hasScores
        tableView.isHidden = !hasScores
        tableView.reloadData()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension ScorePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsWithScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubjectCell.identifier, for: indexPath) as? SubjectCell else {
            return UITableViewCell()
        }
        
        let subjectWithScore = subjectsWithScores[indexPath.row]
        cell.configure(with: subjectWithScore.subject)
        return cell
    }
}
