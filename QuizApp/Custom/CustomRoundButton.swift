//
//  CustomRoundButton.swift
//  QuizApp
//
//  Created by Ana on 11/14/24.
//

import UIKit

final class CustomRoundButton: UIButton {
    
    // MARK: - Initializers
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupButton() {
        backgroundColor = Constants.Colors.yellowPrimary
        layer.cornerRadius = Constants.Layout.setupButtonCornerRadius
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Public Methods
    
    func configure(with image: UIImage?) {
        setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        tintColor = .white
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        if let imageView = imageView {
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: Constants.HomePageConstants.customRoundedButtonWidth),
                imageView.heightAnchor.constraint(equalToConstant: Constants.HomePageConstants.customRoundedButtonHeight),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
}
