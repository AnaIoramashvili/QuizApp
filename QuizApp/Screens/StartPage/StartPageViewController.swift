//
//  StartPageViewController.swift
//  QuizApp
//
//  Created by Ana on 11/12/24.
//

import UIKit

final class StartPageViewController: UIViewController {
    
    // MARK: - Properties
    private var backgroundTopConstraint: NSLayoutConstraint!
    private let viewModel: StartPageViewModel
    
    private let backgroundView: CurvedBackgroundView = {
        let view = CurvedBackgroundView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Label.labelText
        label.textAlignment = .center
        label.textColor = Constants.Colors.neutralWhite
        label.font = UIFont.systemFont(ofSize: Constants.FontSizes.big, weight: .bold)
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
        field.font = UIFont.systemFont(ofSize: Constants.FontSizes.small)
        field.borderStyle = .none
        field.backgroundColor = Constants.Colors.neutralWhite
        field.layer.borderWidth = Constants.Layout.textFieldBorderWidth
        field.layer.borderColor = Constants.Colors.borderColor.cgColor
        field.layer.cornerRadius = Constants.Layout.textFieldCornerRadius
        field.textAlignment = .center
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private lazy var startButton: CustomButton = {
        let button = CustomButton(
            title: Constants.Label.startButtonText,
            height: Constants.Layout.startButtonHeight
        )
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.Layout.startButtonTopPadding
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initialization
    init(viewModel: StartPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupKeyboardObservers()
        setupTapGesture() 
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
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupHierarchy() {
        inputStackView.addArrangedSubviews(
            textField,
            startButton
        )
        
        view.addSubviews(
            backgroundView,
            titleLabel,
            illustrationImageView,
            inputStackView
        )
    }
    
    private func setupConstraints() {
        setupBackgroundViewConstraints()
        setupTitleLabelConstraints()
        setupIllustrationImageConstraints()
        setupStackViewConstraints()
        setupTextFieldConstraints()
        setupStartButtonConstraints()
    }

    private func setupBackgroundViewConstraints() {
        backgroundTopConstraint = backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        
        NSLayoutConstraint.activate([
            backgroundTopConstraint,
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: Constants.Layout.titleLabelTopPadding),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func setupIllustrationImageConstraints() {
        NSLayoutConstraint.activate([
            illustrationImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.Layout.illustrationTopPadding),
            illustrationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.illustrationLeadingPadding),
            illustrationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.Layout.illustrationTrailingPadding),
            illustrationImageView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: Constants.Layout.illustrationBottomPadding)
        ])
    }

    private func setupStackViewConstraints() {
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: Constants.Layout.backgroundBottom)
        ])
    }

    private func setupTextFieldConstraints() {
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: Constants.Layout.textFieldHeight),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.textFieldHorizontalPadding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.textFieldHorizontalPadding)
        ])
    }

    private func setupStartButtonConstraints() {
        NSLayoutConstraint.activate([
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.Layout.startButtonLeadingPadding),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.Layout.startButtonTrailingPadding)
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
    
    @objc private func keyboardWillShow() {
        backgroundTopConstraint.constant = Constants.Layout.keyboardAdjustmentOffset
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        backgroundTopConstraint.constant = Constants.Layout.backgroundImageTopAnchor
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func startButtonTapped() {
        guard let name = textField.text, !name.isEmpty else {
            return
        }
        Task {
            let result = await viewModel.loginUser(with: name)
            
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    let homeVC = HomePageViewController()
                    self.navigationController?.pushViewController(homeVC, animated: true)
                case .failure(let error):
                    print("❌ Login failed: \(error)")
                }
            }
        }
    }
    
    // MARK: - Tap Gesture Setup
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
