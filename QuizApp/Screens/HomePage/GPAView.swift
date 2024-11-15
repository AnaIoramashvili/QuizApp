//
//  GPAView.swift
//  QuizApp
//
//  Created by Ana on 11/15/24.
//

import UIKit

final class GPAView: UIView {
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
        stackView.spacing = Constants.HomePageConstants.gpaStackViewSpacing
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
    
    var onDetailsButtonTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        gpaStackView.addArrangedSubviews(
            gpaLabel,
            gpaDigit
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
        NSLayoutConstraint.activate([
            gpaView.topAnchor.constraint(equalTo: topAnchor),
            gpaView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gpaView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gpaView.bottomAnchor.constraint(equalTo: bottomAnchor),
            gpaView.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.gpaViewHeight),
            
            gpaClearView.leadingAnchor.constraint(
                equalTo: gpaView.leadingAnchor,
                constant: Constants.HomePageConstants.gpaClearViewLeadingPadding
            ),
            gpaClearView.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            gpaClearView.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.gpaClearViewHeight),
            
            gpaStackView.leadingAnchor.constraint(
                equalTo: gpaClearView.leadingAnchor,
                constant: Constants.HomePageConstants.gpaStackViewPadding
            ),
            gpaStackView.trailingAnchor.constraint(
                equalTo: gpaClearView.trailingAnchor,
                constant: -Constants.HomePageConstants.gpaStackViewPadding
            ),
            gpaStackView.centerYAnchor.constraint(equalTo: gpaClearView.centerYAnchor),
            
            detailsButton.trailingAnchor.constraint(
                equalTo: gpaView.trailingAnchor,
                constant: Constants.HomePageConstants.detailsButtonTrailingPadding
            ),
            detailsButton.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            
            nextArrow.trailingAnchor.constraint(
                equalTo: gpaView.trailingAnchor,
                constant: Constants.HomePageConstants.nextArrowTrailingPadding
            ),
            nextArrow.centerYAnchor.constraint(equalTo: gpaView.centerYAnchor),
            nextArrow.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.nextArrowHeight),
            nextArrow.widthAnchor.constraint(equalToConstant: Constants.HomePageConstants.nextArrowWidth)
        ])
    }
}
