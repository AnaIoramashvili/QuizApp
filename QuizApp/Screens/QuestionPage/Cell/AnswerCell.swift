//
//  AnswerCell.swift
//  QuizApp
//
//  Created by Ana on 11/26/24.
//

import UIKit

final class AnswerCell: UITableViewCell {
    
    // MARK: - Static Properties
    static let identifier = Constants.QuizViewControllerConstants.identifier
    
    // MARK: - Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.neutralLighterGray
        view.layer.cornerRadius = Constants.AnswerCellConstants.containerCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSizes.medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.AnswerCellConstants.scoreLabel
        label.textAlignment = .right
        label.font = .systemFont(ofSize: Constants.FontSizes.small14, weight: .semibold)
        label.textColor = Constants.Colors.neutralWhite
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.AnswerCellConstants.whiteStarImage)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setUp() {
        setupView()
        setUpHierarchy()
        setUpConstraints()
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setUpHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubviews(
            titleLabel,
            scoreLabel,
            starImageView
        )
    }
    
    private func setUpConstraints() {
        setupContainerViewConstraints()
        setupTitleLabelConstraints()
        setupScoreLabelConstraints()
        setupStarImageViewConstraints()
    }
    
    // MARK: - Constraint Setup Methods
    private func setupContainerViewConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constants.AnswerCellConstants.containerVerticalPadding
            ),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.AnswerCellConstants.containerVerticalPadding
            ),
            containerView.heightAnchor.constraint(equalToConstant: Constants.AnswerCellConstants.containerHeight)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: Constants.AnswerCellConstants.titleLabelHorizontalPadding
            ),
            titleLabel.trailingAnchor.constraint(
                equalTo: scoreLabel.leadingAnchor,
                constant: -Constants.AnswerCellConstants.titleLabelHorizontalPadding
            ),
            titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func setupScoreLabelConstraints() {
        NSLayoutConstraint.activate([
            scoreLabel.trailingAnchor.constraint(
                equalTo: starImageView.leadingAnchor,
                constant: Constants.AnswerCellConstants.scoreLabelPadding
            ),
            scoreLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func setupStarImageViewConstraints() {
        NSLayoutConstraint.activate([
            starImageView.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -Constants.AnswerCellConstants.titleLabelHorizontalPadding
            ),
            starImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            starImageView.heightAnchor.constraint(equalToConstant: Constants.AnswerCellConstants.starImageHeight)
        ])
    }
    
    // MARK: - Configuration
    func configure(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Color Changing Success/Wrong
    func updateState(isCorrect: Bool) {
        if isCorrect {
            // Correct answer
            containerView.backgroundColor = Constants.AnswerCellConstants.success
            titleLabel.textColor = Constants.Colors.neutralWhite
            scoreLabel.isHidden = false
            starImageView.isHidden = false
        } else {
            // Wrong answer
            containerView.backgroundColor = Constants.AnswerCellConstants.wrong
            titleLabel.textColor = Constants.Colors.neutralWhite
            scoreLabel.isHidden = true
            starImageView.isHidden = true
        }
    }
    
    func markAsCorrect() {
        // Show correct answer cell styling without +1 or star
        containerView.backgroundColor = Constants.AnswerCellConstants.success
        titleLabel.textColor = Constants.Colors.neutralWhite
        scoreLabel.isHidden = true
        starImageView.isHidden = true
    }
    
    func resetState() {
        // Reset cell to default state
        containerView.backgroundColor = Constants.Colors.neutralLighterGray
        titleLabel.textColor = Constants.Colors.neutralDarkGrey
        scoreLabel.isHidden = true
        starImageView.isHidden = true
    }
}
