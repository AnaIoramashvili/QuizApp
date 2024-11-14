//
//  CustomButton.swift
//  QuizApp
//
//  Created by Ana on 11/13/24.
//

import UIKit

class CustomButton: UIButton {
    // MARK: - Properties
    private var buttonHeight: CGFloat
    
    // MARK: - Initialization
    init(title: String, height: CGFloat) {
        self.buttonHeight = height
        super.init(frame: .zero)
        setup(with: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setup(with title: String) {
        setTitle(title, for: .normal)
        backgroundColor = Constants.Colors.buttonColor
        setTitleColor(Constants.Colors.neutralWhite, for: .normal)
        titleLabel?.font = .systemFont(ofSize: Constants.FontSizes.buttonFontSize, weight: .semibold)
        layer.cornerRadius = Constants.Layout.startButtonCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
        setupHeightConstraint()
    }
    
    // MARK: - Layout
    private func setupHeightConstraint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    // MARK: - Public Methods
    func updateSize(height: CGFloat) {
        self.buttonHeight = height
        invalidateIntrinsicContentSize()
    }
}
