//
//  HomePageViewController.swift
//  QuizApp
//
//  Created by Ana on 11/14/24.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomePageConstants.helloText
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
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        return logOutButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = Constants.Colors.neutralWhite
        navigationController?.isNavigationBarHidden = true
        setupTableView()
        setUpHierarchy()
        setUpConstraints()
    }
    
    private func setUpHierarchy() {
        view.addSubviews(
            headerLabel,
            gpaView,
            subjectsLabel,
            tableView,
            bottomSeparatorLine,
            logOutButton
        )
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate(
            [
                headerLabel.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: Constants.HomePageConstants.headerTopPadding
                ),
                headerLabel.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.HomePageConstants.horizontalPadding
                ),
                
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
                ),
                subjectsLabel.topAnchor.constraint(
                    equalTo: gpaView.bottomAnchor,
                    constant: Constants.HomePageConstants.subjectsLabelTopPadding
                ),
                subjectsLabel.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.HomePageConstants.horizontalPadding
                ),
                
                tableView.topAnchor.constraint(
                    equalTo: subjectsLabel.bottomAnchor,
                    constant: Constants.HomePageConstants.tableViewTopPadding
                ),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: bottomSeparatorLine.topAnchor),
                
                bottomSeparatorLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                bottomSeparatorLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomSeparatorLine.heightAnchor.constraint(
                    equalToConstant: Constants.HomePageConstants.bottomSeparatorLine
                ),
                bottomSeparatorLine.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: Constants.HomePageConstants.bottomSeparatorLinePadding
                ),
                
                logOutButton.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Constants.HomePageConstants.logOutButtonLeadingPadding
                ),
                logOutButton.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: Constants.HomePageConstants.logoutButtonBottomPadding
                )
            ]
        )
     }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SubjectCell.self, forCellReuseIdentifier: SubjectCell.identifier)
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubjectCell.identifier, for: indexPath) as? SubjectCell else {
            return UITableViewCell()
        }
        cell.configure(with: subjects[indexPath.row])
        return cell
    }
}
