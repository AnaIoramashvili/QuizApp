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
    
    private let gpaView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.blueSecondaryDefault
        view.layer.cornerRadius = Constants.Layout.gpaViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gpaClearView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.blueSecondaryLighter
        view.layer.cornerRadius = Constants.Layout.gpaClearViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gpaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let gpaLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomePageConstants.gpaText
        label.textColor = Constants.Colors.neutralWhite
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        return label
    }()
    
    private let gpaDigit: UILabel = {
        let label = UILabel()
        label.text = Constants.HomePageConstants.gpaDigit
        label.textColor = Constants.Colors.yellowPrimary
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        return label
    }()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.HomePageConstants.detailsButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.Images.nextArrow)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        gpaStackView.addArrangedSubviews(
            gpaLabel,
            gpaDigit
        )
        
        view.addSubviews(
            headerLabel,
            gpaView,
            gpaClearView,
            gpaStackView,
            detailsButton,
            nextArrow,
            subjectsLabel,
            tableView
        )
    }
    
    private func setUpConstraints() {
         NSLayoutConstraint.activate([
             headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.HomePageConstants.headerTopPadding),
             headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.HomePageConstants.horizontalPadding),
             
             gpaView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: Constants.HomePageConstants.gpaViewTopPadding),
             gpaView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.HomePageConstants.horizontalPadding),
             gpaView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.HomePageConstants.horizontalPadding),
             gpaView.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.gpaViewHeight),
             
             gpaClearView.leadingAnchor.constraint(equalTo: gpaView.leadingAnchor, constant: Constants.HomePageConstants.gpaClearViewLeadingPadding),
             gpaClearView.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
             gpaClearView.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.gpaClearViewHeight),
             
             gpaStackView.leadingAnchor.constraint(equalTo: gpaClearView.leadingAnchor, constant: Constants.HomePageConstants.gpaStackViewPadding),
             gpaStackView.trailingAnchor.constraint(equalTo: gpaClearView.trailingAnchor, constant: -Constants.HomePageConstants.gpaStackViewPadding),
             gpaStackView.centerYAnchor.constraint(equalTo: gpaClearView.centerYAnchor),
             
             detailsButton.trailingAnchor.constraint(equalTo: gpaView.trailingAnchor, constant: Constants.HomePageConstants.detailsButtonTrailingPadding),
             detailsButton.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
             
             nextArrow.trailingAnchor.constraint(equalTo: gpaView.trailingAnchor, constant: Constants.HomePageConstants.nextArrowTrailingPadding),
             nextArrow.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
             nextArrow.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.nextArrowHeight),
             nextArrow.widthAnchor.constraint(equalToConstant: Constants.HomePageConstants.nextArrowWidth),
             
             subjectsLabel.topAnchor.constraint(equalTo: gpaView.bottomAnchor, constant: Constants.HomePageConstants.subjectsLabelTopPadding),
             subjectsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.HomePageConstants.horizontalPadding),
             
             tableView.topAnchor.constraint(equalTo: subjectsLabel.bottomAnchor, constant: Constants.HomePageConstants.tableViewTopPadding),
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
