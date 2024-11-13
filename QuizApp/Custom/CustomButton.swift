//
//  CustomButton.swift
//  QuizApp
//
//  Created by Ana on 11/13/24.
//

import UIKit

class CustomButton: UIButton {
    // MARK: - Properties
    private var buttonWidth: CGFloat
    private var buttonHeight: CGFloat
    
    // MARK: - Initialization
    init(title: String, width: CGFloat, height: CGFloat) {
        self.buttonWidth = width
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
    }
    
    // MARK: - Layout
    override var intrinsicContentSize: CGSize {
        return CGSize(width: buttonWidth, height: buttonHeight)
    }
    
    // MARK: - Public Methods
    func updateSize(width: CGFloat, height: CGFloat) {
        self.buttonWidth = width
        self.buttonHeight = height
        invalidateIntrinsicContentSize()
    }
}