//
//  CustomRoundButton.swift
//  QuizApp
//
//  Created by Ana on 11/14/24.
//

import UIKit

final class CustomRoundButton: UIButton {
    
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
    
    private func setupButton() {
        backgroundColor = Constants.Colors.yellowPrimary
        layer.cornerRadius = 22.5
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 45),
            heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func configure(with image: UIImage?) {
        setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        imageView?.contentMode = .scaleAspectFit
        tintColor = .white
        
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        if let imageView = imageView {
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 20),
                imageView.heightAnchor.constraint(equalToConstant: 20),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    }
}
