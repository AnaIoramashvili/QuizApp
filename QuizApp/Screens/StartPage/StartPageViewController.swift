//
//  StartPageViewController.swift
//  QuizApp
//
//  Created by Ana on 11/12/24.
//

import UIKit

class StartPageViewController: UIViewController {
    
    // MARK: - Properties
    private var textFieldTopConstraint: NSLayoutConstraint!
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "backgroundShape")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ჩემი პირველი ქვიზი"
        label.textAlignment = .center
        label.textColor = Constants.Colors.textWhite
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.titleFontSize, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "student_illustration")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "შეიყვანე სახელი"
        field.font = UIFont.systemFont(ofSize: Constants.FontSizes.textFieldFontSize)
        field.borderStyle = .none
        field.backgroundColor = Constants.Colors.backgroundWhite
        field.layer.borderWidth = Constants.Layout.textFieldBorderWidth
        field.layer.borderColor = Constants.Colors.yellowPrimary.cgColor
        field.layer.cornerRadius = Constants.Layout.textFieldCornerRadius
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("ქვიზის დაწყება", for: .normal)
        button.backgroundColor = Constants.Colors.yellowPrimary
        button.setTitleColor(Constants.Colors.textWhite, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constants.FontSizes.buttonFontSize, weight: .semibold)
        button.layer.cornerRadius = Constants.Layout.startButtonCornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupConstraints()
        setupUI()
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObservers()
    }
    
    // MARK: - Setup Functions
    private func setupUI() {
        view.backgroundColor = .black
    }
    
    private func setupHierarchy() {
        view.addSubviews(
        backgroundImageView,
         titleLabel, 
         illustrationImageView, 
         textField,
          startButton
          )
    }
    
    private func setupConstraints() {
        textFieldTopConstraint = textField.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: Constants.Layout.textFieldTopPadding)
        
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
            
            textFieldTopConstraint,
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.textFieldHorizontalPadding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.textFieldHorizontalPadding),
            textField.heightAnchor.constraint(equalToConstant: Constants.Layout.textFieldHeight),
            
            startButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.Layout.startButtonTopPadding),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: Constants.Layout.startButtonWidth),
            startButton.heightAnchor.constraint(equalToConstant: Constants.Layout.startButtonHeight)
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
            textFieldTopConstraint.constant = -keyboardHeight/2
            
            UIView.animate(withDuration: 0.1) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        textFieldTopConstraint.constant = Constants.Layout.textFieldTopPadding
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
}
