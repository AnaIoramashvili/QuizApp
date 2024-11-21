//
//  CustomPopUp.swift
//  QuizApp
//
//  Created by Ana on 11/19/24.
//

import UIKit

final class CustomPopUp: UIView {

    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = Constants.Sizing.stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: Constants.FontSize.medium, weight: .bold)
        label.textColor = Constants.Colors.neutralWhite
        return label
    }()

    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = Constants.Sizing.buttonsSpacing
        stackView.distribution = .fillEqually
        return stackView
    }()

    lazy var rejectButton: PopupButton = {
        let button = PopupButton()
        button.configure(title: Constants.Texts.rejectButtonTitle)
        button.addTarget(self, action: #selector(handleNoButtonTap), for: .touchUpInside)
        return button
    }()

    lazy var acceptButton: PopupButton = {
        let button = PopupButton()
        button.configure(title: Constants.Texts.acceptButtonTitle)
        button.addTarget(self, action: #selector(handleYesButtonTap), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        setupView()
        setupHierarchy()
        mainStackViewConstraints()
    }

    private func setupView() {
        backgroundColor = Constants.Colors.yellowPrimary
        layer.cornerRadius = Constants.Sizing.radius
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupHierarchy() {
        addSubviews(stackView)
        buttonsStackView.addArrangedSubviews(
            rejectButton,
            acceptButton
        )
        stackView.addArrangedSubviews(
            questionLabel,
            buttonsStackView
        )
    }
    // MARK: - Constraints

    private func mainStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.Sizing.verticalPadding),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.Sizing.sidePadding),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.Sizing.sidePadding),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.Sizing.verticalPadding)
        ])
    }

    // MARK: - Configure View
    func configure(question: String) {
        questionLabel.text = question
    }

    // MARK: - Actions
    
    var acceptButtonTap: (() -> Void)?
    var rejectButtonTap: (() -> Void)?
    
    @objc func handleYesButtonTap() {
        acceptButtonTap?()
    }

    @objc func handleNoButtonTap() {
        rejectButtonTap?()
    }
}

// MARK: - Constants Extension
extension CustomPopUp {
    enum Constants {
        enum Sizing {
            static let radius: CGFloat = 31
            static let sidePadding: CGFloat = -24
            static let verticalPadding: CGFloat = -39
            static let stackViewSpacing: CGFloat = 20
            static let buttonsSpacing: CGFloat = 10
        }

        enum Texts {
            static let rejectButtonTitle = "არა"
            static let acceptButtonTitle = "კი"
        }

        enum FontSize {
            static let medium: CGFloat = 16
        }

        enum Colors {
            static let neutralWhite: UIColor = .white
            static let yellowPrimary: UIColor = UIColor(hex: "#FFC44A")
        }
    }
}
