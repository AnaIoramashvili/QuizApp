//
//  ScorePopUp.swift
//  QuizApp
//
//  Created by Ana on 11/19/24.
//

import UIKit

final class ScorePopUp: UIView {

    // MARK: - Properties
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Sizing.stackViewSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSizes.medium14, weight: .bold)
        label.textColor = Constants.Colors.blueSecondaryDefault
        return label
    }()

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.neutralLighterGrey
        return view
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.Texts.closeButtonTitle, for: .normal)
        button.titleLabel?.textColor = Constants.Colors.neutralWhite
        button.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
        setupViewHierarchy()
        setConstraints()
        setCustomSpacings()
        setTitle()
    }

    private func setupView() {
        backgroundColor = Constants.Colors.yellowPrimary
        layer.cornerRadius = Constants.Sizing.radius
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupViewHierarchy() {
        addSubviews(stackView, closeButton)
        stackView.addArrangedSubviews(
            titleLabel,
            pointsLabel,
            separatorView
        )
    }
    
    // MARK: - Set Up Title
    private func setTitle() {
        let emoji = Constants.Texts.emoji
        let message = Constants.Texts.message
        
        let emojiAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.FontSizes.big)
        ]
        
        let messageAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.FontSizes.medium, weight: .bold),
            .foregroundColor: Constants.Colors.neutralWhite
        ]
        
        let emojiAttributedString = NSAttributedString(string: emoji, attributes: emojiAttributes)
        let messageAttributedString = NSAttributedString(string: "\n\(message)", attributes: messageAttributes)
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(emojiAttributedString)
        combinedAttributedString.append(messageAttributedString)
        
        titleLabel.attributedText = combinedAttributedString
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        configureMainStackViewConstraints()
        configureSeparatorConstraints()
        configureCloseButtonConstraints()
    }
    
    private func configureMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

    private func configureSeparatorConstraints() {
        NSLayoutConstraint.activate([
            separatorView.heightAnchor.constraint(equalToConstant: Constants.Sizing.separatorHeight),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.Sizing.separatorBottomAnchor)
        ])
    }

    private func configureCloseButtonConstraints() {
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.Sizing.closeButtonHeightAnchor)
        ])
    }

    private func setCustomSpacings() {
        stackView.setCustomSpacing(
            Constants.Sizing.customSpacingAfterPoints,
            after: pointsLabel
        )
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: Constants.Sizing.stackViewTopPadding,
            left: Constants.Sizing.sidePadding,
            bottom: Constants.Sizing.stackViewBottomPadding,
            right: Constants.Sizing.sidePadding
        )
    }

    // MARK: - View Configure
    func configure(points: Int) {
        pointsLabel.text = String(
            format: Constants.Texts.pointsMessage,
            points
        )
    }
    
    // MARK: - Actions
    var closeAction: (() -> Void)?

    @objc func closeClicked() {
        closeAction?()
    }
}

// MARK: - Constants Extension
extension ScorePopUp {
    enum Constants {
        enum Sizing {
            static let radius: CGFloat = 31
            static let sidePadding: CGFloat = 24
            static let stackViewSpacing: CGFloat = 4
            static let customSpacingAfterPoints: CGFloat = 32
            static let separatorHeight: CGFloat = 1
            static let separatorBottomAnchor: CGFloat = -44.5
            static let closeButtonHeightAnchor: CGFloat = 44
            static let stackViewTopPadding: CGFloat = 39
            static let stackViewBottomPadding: CGFloat = -34
        }

        enum Texts {
            static let emoji = "🎉"
            static let message = "გილოცავ!"
            static let closeButtonTitle = "დახურვა"
            static let pointsMessage = "შენ დააგროვე %d ქულა"
        }

        enum FontSizes {
            static let medium14: CGFloat = 14
            static let medium: CGFloat = 16
            static let big: CGFloat = 32
        }

        enum Colors {
            static let neutralDarkGrey = UIColor(hex: "1D1D1D")
            static let neutralGrey = UIColor(hex: "B3B3B3")
            static let neutralWhite: UIColor = .white
            static let neutralLighterGrey = UIColor(hex: "F6F6F6")
            static let yellowPrimary = UIColor(hex: "#FFC44A")
            static let blueSecondaryDefault = UIColor(hex: "#537FE7")
            static let blueSecondaryLighter = UIColor(hex: "#6B91EA")
            static let blueSecondaryLightest = UIColor(hex: "#C0D0F6")
        }
    }
}
