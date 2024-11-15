//
//  SubjectCell.swift
//  QuizApp
//
//  Created by Ana on 11/14/24.
//

import UIKit

final class SubjectCell: UITableViewCell {
    static let identifier = Constants.SubjectTableViewCellConstants.identifier
    
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
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.small)
        label.textColor = Constants.Colors.neutralGrey
        return label
    }()
    
    private let arrowButton: UIButton = {
        let arrowButton = CustomRoundButton()
        arrowButton.configure(with: UIImage(named: Constants.Images.arrowButton))
        return arrowButton
    }()
    
    private let labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.SubjectTableViewCellConstants.descriptionTopPadding
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Constants.SubjectTableViewCellConstants.labelLeadingPadding
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        containerView.addSubview(contentStackView)
        
        labelsStackView.addArrangedSubviews(
            titleLabel,
            descriptionLabel
        )
        
        contentStackView.addArrangedSubviews(
            iconImageView,
            labelsStackView,
            arrowButton
        )
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.SubjectTableViewCellConstants.containerVerticalPadding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.SubjectTableViewCellConstants.containerHorizontalPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.SubjectTableViewCellConstants.containerHorizontalPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.SubjectTableViewCellConstants.containerVerticalPadding),
            containerView.heightAnchor.constraint(equalToConstant: Constants.SubjectTableViewCellConstants.containerHeight),
            
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.SubjectTableViewCellConstants.iconLeadingPadding),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constants.SubjectTableViewCellConstants.arrowTrailingPadding),
            contentStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.SubjectTableViewCellConstants.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.SubjectTableViewCellConstants.iconSize)
        ])
    }
    
    func configure(with subject: Subject) {
        iconImageView.image = subject.icon
        titleLabel.text = subject.title
        descriptionLabel.text = subject.description
    }
}
