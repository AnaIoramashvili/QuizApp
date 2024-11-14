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
        label.text = Constants.HomeLabel.helloText
        label.textColor = Constants.Colors.yellowPrimary
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gpaView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.blueSecondaryDefault
        view.layer.cornerRadius = Constants.Layout.gpaViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gpaLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomeLabel.gpaText
        label.textColor = Constants.Colors.neutralWhite
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gpaDigit: UILabel = {
        let label = UILabel()
        label.text = Constants.HomeLabel.gpaDigit
        label.textColor = Constants.Colors.yellowPrimary
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("დეტალურად", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let subjectsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomeLabel.chooseSubject
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        setupTableView()
        setUpHierarchy()
        setUpConstraints()
    }
    
    private func setUpHierarchy() {
        view.addSubview(headerLabel)
        view.addSubview(gpaView)
        gpaView.addSubview(gpaLabel)
        gpaView.addSubview(gpaDigit)
        gpaView.addSubview(detailsButton)
        view.addSubview(subjectsLabel)
        view.addSubview(tableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            gpaView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            gpaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gpaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            gpaView.heightAnchor.constraint(equalToConstant: 75),
            
            gpaLabel.leadingAnchor.constraint(equalTo: gpaView.leadingAnchor, constant: 18),
            gpaLabel.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            
            gpaDigit.leadingAnchor.constraint(equalTo: gpaView.leadingAnchor, constant: 68),
            gpaDigit.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            
            detailsButton.trailingAnchor.constraint(equalTo: gpaView.trailingAnchor, constant: -34),
            detailsButton.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            
            subjectsLabel.topAnchor.constraint(equalTo: gpaView.bottomAnchor, constant: 32),
            subjectsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: subjectsLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
