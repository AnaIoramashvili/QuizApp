//
//  QuizQuestionView.swift
//  QuizApp
//
//  Created by Ana on 11/26/24.
//

import UIKit

final class QuizQuestionView: UIView {

    // MARK: - UI Components
    private let questionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: Constants.FontSizes.small14, weight: .medium)
        textView.textColor = Constants.Colors.neutralDarkGrey
        textView.textAlignment = .center
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
        setAppearance()
        setupViewHierarchy()
        setConstraints()
    }

    private func setAppearance() {
        backgroundColor = Constants.Colors.blueSecondaryLightest
        layer.cornerRadius = Constants.QuizQuestionViewConstants.radius
    }

    private func setupViewHierarchy() {
        addSubview(questionTextView)
    }

    // MARK: - Constraints
    private func setConstraints() {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: Constants.QuizQuestionViewConstants.height),
            questionTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            questionTextView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: Constants.QuizQuestionViewConstants.sidePadding),
            questionTextView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Constants.QuizQuestionViewConstants.sidePadding),
            questionTextView.heightAnchor.constraint(equalToConstant: CGFloat((Constants.QuizQuestionViewConstants.questionViewHeight)))
        ])
    }

    // MARK: - Configure View
    func configure(question: String) {
        questionTextView.text = question
    }
}

