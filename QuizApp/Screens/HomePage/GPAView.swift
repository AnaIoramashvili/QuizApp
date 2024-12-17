//
//  GPAView.swift
//  QuizApp
//
//  Created by Ana on 11/15/24.
//

import UIKit

protocol GPAViewDelegate: AnyObject {
    func didTapDetailsButton()
}

final class GPAView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: GPAViewDelegate?
    
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
        stackView.spacing = Constants.HomePageConstants.gpaStackViewSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let gpaLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomePageConstants.gpaText
        label.textColor = Constants.Colors.neutralWhite
        label.font = .systemFont(ofSize: Constants.FontSizes.medium)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.HomePageConstants.gpaDigit
        label.textColor = Constants.Colors.yellowPrimary
        label.font = .systemFont(ofSize: Constants.FontSizes.medium)
        return label
    }()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.HomePageConstants.detailsButtonText, for: .normal)
        button.setTitleColor(Constants.Colors.neutralWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.FontSizes.small)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let nextArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.Images.nextArrow)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        gpaStackView.addArrangedSubviews(
            gpaLabel,
            scoreLabel
        )
        
        addSubview(gpaView)
        gpaView.addSubviews(
            gpaClearView,
            gpaStackView,
            detailsButton,
            nextArrow
        )
    }
    
    private func setupConstraints() {
        setupGPAViewConstraints()
        setupGPAClearViewConstraints()
        setupGPAStackViewConstraints()
        setupDetailsButtonConstraints()
        setupNextArrowConstraints()
    }

    // MARK: - Constraints Setup Methods
    private func setupGPAViewConstraints() {
        NSLayoutConstraint.activate([
            gpaView.topAnchor.constraint(equalTo: topAnchor),
            gpaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gpaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gpaView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gpaView.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.gpaViewHeight)
        ])
    }

    private func setupGPAClearViewConstraints() {
        NSLayoutConstraint.activate([
            gpaClearView.leadingAnchor.constraint(
                equalTo: gpaView.leadingAnchor,
                constant: Constants.HomePageConstants.gpaClearViewLeadingPadding
            ),
            gpaClearView.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            gpaClearView.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.gpaClearViewHeight)
        ])
    }

    private func setupGPAStackViewConstraints() {
        NSLayoutConstraint.activate([
            gpaStackView.leadingAnchor.constraint(
                equalTo: gpaClearView.leadingAnchor,
                constant: Constants.HomePageConstants.gpaStackViewPadding
            ),
            gpaStackView.trailingAnchor.constraint(
                equalTo: gpaClearView.trailingAnchor,
                constant: -Constants.HomePageConstants.gpaStackViewPadding
            ),
            gpaStackView.centerYAnchor.constraint(equalTo: gpaClearView.centerYAnchor)
        ])
    }

    private func setupDetailsButtonConstraints() {
        NSLayoutConstraint.activate([
            detailsButton.trailingAnchor.constraint(
                equalTo: gpaView.trailingAnchor,
                constant: Constants.HomePageConstants.detailsButtonTrailingPadding
            ),
            detailsButton.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor)
        ])
    }

    private func setupNextArrowConstraints() {
        NSLayoutConstraint.activate([
            nextArrow.trailingAnchor.constraint(
                equalTo: gpaView.trailingAnchor,
                constant: Constants.HomePageConstants.nextArrowTrailingPadding
            ),
            nextArrow.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            nextArrow.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.nextArrowHeight),
            nextArrow.widthAnchor.constraint(equalToConstant: Constants.HomePageConstants.nextArrowWidth)
        ])
    }
    
    @objc private func detailsButtonTapped() {
        delegate?.didTapDetailsButton()
    }
    
    // MARK: - Public Methods
    func updateScore(_ score: Double) {
        scoreLabel.text = String(format: "%.1f", max(0, min(score, 4.0)))
    }
}
