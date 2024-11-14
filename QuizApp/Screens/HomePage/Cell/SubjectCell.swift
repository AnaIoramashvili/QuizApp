//
//  SubjectCell.swift
//  QuizApp
//
//  Created by Ana on 11/14/24.
//

import UIKit

class SubjectCell: UITableViewCell {
    static let identifier = "SubjectCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.neutralLighterGray
        view.layer.cornerRadius = Constants.Layout.containerCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.medium)
        label.textColor = Constants.Colors.neutralDarkGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.small)
        label.textColor = Constants.Colors.neutralGrey
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let arrowButton: UIButton = {
        let arrowButton = CustomRoundButton()
        arrowButton.configure(with: UIImage(named: "arrow"))
        return arrowButton
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        setUpHierarchy()
        setUpConstraints()
    }
    
    private func setUpHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(arrowButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            containerView.heightAnchor.constraint(equalToConstant: 106),
            
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 64),
            iconImageView.heightAnchor.constraint(equalToConstant: 64),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
            titleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            arrowButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            arrowButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    func configure(with subject: Subject) {
        iconImageView.image = subject.icon
        titleLabel.text = subject.title
        descriptionLabel.text = subject.description
    }
}

