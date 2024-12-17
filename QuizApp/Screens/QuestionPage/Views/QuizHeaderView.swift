//
//  QuizHeaderView.swift
//  QuizApp
//
//  Created by Ana on 11/26/24.
//

import UIKit

protocol QuizHeaderViewDelegate: AnyObject {
    func didTapCloseButton()
}

final class QuizHeaderView: UIView {
    // MARK: - Properties
    weak var delegate: QuizHeaderViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSizes.medium, weight: .bold)
        label.textAlignment = .center
        label.textColor = Constants.Colors.neutralDarkGrey
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: Constants.QuizHeaderViewConstants.closeButtonImage)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // Empty views for spacing
    private let leadingSpacerView = UIView()
    private let trailingSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leadingSpacerView, titleLabel, closeButton])
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupUI() {
        setupViewHierarchy()
        setConstraints()
    }
    
    private func setupViewHierarchy() {
        addSubview(stackView)
    }
        
    // MARK: - Constraints
    private func setConstraints() {
        stackViewConstraints()
        leadingSpacerViewConstraints()
        closeButtonSizeConstraints()
    }
    
    private func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func leadingSpacerViewConstraints() {
        NSLayoutConstraint.activate([
            leadingSpacerView.widthAnchor.constraint(equalToConstant: Constants.QuizHeaderViewConstants.leadingSpacerView),
        ])
    }
    
    private func closeButtonSizeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: Constants.QuizHeaderViewConstants.closeButtonWidth),
            closeButton.heightAnchor.constraint(equalToConstant: Constants.QuizHeaderViewConstants.closeButtonHeight)
        ])
    }
    
    // MARK: - Actions
    @objc private func closeButtonTapped() {
        delegate?.didTapCloseButton()
    }
    
    // MARK: - Public Methods
    func configure(with title: String) {
        titleLabel.text = title
    }
}
