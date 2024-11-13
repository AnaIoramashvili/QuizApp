//
//  StartPageViewController.swift
//  QuizApp
//
//  Created by Ana on 11/12/24.
//

import UIKit

class StartPageViewController: UIViewController {
    
    // MARK: - Properties
    private var stackViewTopConstraint: NSLayoutConstraint!
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Constants.Images.backgroundShape)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Label.labelText
        label.textAlignment = .center
        label.textColor = Constants.Colors.neutralWhite
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.titleFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.Images.studentIllustration)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = Constants.Label.placeholderText
        field.font = UIFont.systemFont(ofSize: Constants.FontSizes.textFieldFontSize)
        field.borderStyle = .none
        field.backgroundColor = Constants.Colors.neutralWhite
        field.layer.borderWidth = Constants.Layout.textFieldBorderWidth
        field.layer.borderColor = Constants.Colors.borderColor.cgColor
        field.layer.cornerRadius = Constants.Layout.textFieldCornerRadius
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let startButton: CustomButton = {
        let button = CustomButton(
            title: Constants.Label.startButtonText,
            width: Constants.Layout.startButtonWidth,
            height: Constants.Layout.startButtonHeight
        )
        return button
    }()
    
    private let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Layout.startButtonTopPadding
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupKeyboardObservers()
    }
    
    private func setUp() {
        setupHierarchy()
        setupConstraints()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObservers()
    }
    
    // MARK: - Setup Functions
    private func setupUI() {
        view.backgroundColor = Constants.Colors.neutralWhite
    }
    
    private func setupHierarchy() {
        inputStackView.addArrangedSubviews(
            textField,
            startButton
        )
        
        view.addSubviews(
            backgroundImageView,
            titleLabel,
            illustrationImageView,
            inputStackView
        )
    }
    
    private func setupConstraints() {
        stackViewTopConstraint = inputStackView.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: Constants.Layout.textFieldTopPadding)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.backgroundImageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Layout.titleLabelTopPadding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            illustrationImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.Layout.illustrationTopPadding),
            illustrationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.illustrationLeadingPadding),
            illustrationImageView.widthAnchor.constraint(equalToConstant: Constants.Layout.illustrationImageWidth),
            illustrationImageView.heightAnchor.constraint(equalToConstant: Constants.Layout.illustrationImageHeight),
            
            stackViewTopConstraint,
            inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.textFieldHorizontalPadding),
            inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.textFieldHorizontalPadding),
            
            textField.heightAnchor.constraint(equalToConstant: Constants.Layout.textFieldHeight),
            textField.widthAnchor.constraint(equalTo: inputStackView.widthAnchor),
            
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.startButtonLeadingPadding),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.startButtonTrailingPadding),
        ])
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            stackViewTopConstraint.constant = -keyboardHeight/2
            
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        stackViewTopConstraint.constant = Constants.Layout.textFieldTopPadding
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}
