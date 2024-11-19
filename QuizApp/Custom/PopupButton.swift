//
//  PopupButton.swift
//  QuizApp
//
//  Created by Ana on 11/19/24.
//

import UIKit

final class PopupButton: UIButton {

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configurations
    private func setupUI() {
        setupView()
        setConstraints()
    }

    private func setupView() {
        backgroundColor = Constants.Colors.backgroundColor
        titleLabel?.font = .systemFont(ofSize: Constants.Sizing.mediumFontSize, weight: .bold)
        setTitleColor(Constants.Colors.neutralDarkGrey, for: .normal)
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        layer.cornerRadius = Constants.Sizing.radius
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }

    func configure(title: String) {
        setTitle(title, for: .normal)
    }

    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: Constants.Sizing.height)
        ])
    }
}

// MARK: - Constants Extension
private extension PopupButton {
    enum Constants {
        enum Sizing {
            static let height: CGFloat = 34
            static let radius: CGFloat = height / 2
            static let mediumFontSize: CGFloat = 16
        }

        enum Colors {
            static let backgroundColor = UIColor.white.withAlphaComponent(0.6)
            static let neutralDarkGrey: UIColor = UIColor(hex: "#1D1D1D")
        }
    }
}
