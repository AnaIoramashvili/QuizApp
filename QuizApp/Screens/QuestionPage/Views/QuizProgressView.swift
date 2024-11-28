//
//  QuizProgressView.swift
//  QuizApp
//
//  Created by Ana on 11/26/24.
//

import UIKit

final class QuizProgressView: UIView {
    
    // MARK: - Properties
    private let progressBar: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = Constants.Colors.blueSecondaryDefault
        progress.trackTintColor = Constants.Colors.neutralLighterGray
        progress.layer.cornerRadius = Constants.QuizProgressViewConstants.radius
        progress.clipsToBounds = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    private let questionCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSizes.small14, weight: .medium)
        label.textColor = Constants.Colors.neutralDarkGrey
        return label
    }()
    
    private let pointsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.QuizProgressViewConstants.currentScore
        label.font = .systemFont(ofSize: Constants.FontSizes.small14, weight: .medium)
        label.textColor = Constants.Colors.yellowPrimary
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSizes.small14, weight: .medium)
        label.textColor = Constants.Colors.yellowPrimary
        return label
    }()
    
    private lazy var pointsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pointsTitleLabel, pointsLabel])
        stack.alignment = .center
        stack.spacing = Constants.QuizProgressViewConstants.pointsStackSpacing
        return stack
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [questionCountLabel, pointsStackView])
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topStackView, progressBar])
        stack.axis = .vertical
        stack.spacing = Constants.QuizProgressViewConstants.mainStackSpacing
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
        setInitialState()
    }
    private func setupViewHierarchy() {
        addSubview(mainStackView)
    }
    
    //Will be changed
    private func setInitialState() {
        updateProgress(currentQuestion: 1, totalQuestions: 10)
        updatePoints(points: 1)
    }
    
    // MARK: - Constraints
    private func setConstraints() {
        mainStackViewConstraints()
        progressBarConstraints()
    }
    
    private func mainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func progressBarConstraints() {
        NSLayoutConstraint.activate([
            progressBar.heightAnchor.constraint(equalToConstant: Constants.QuizProgressViewConstants.progressBarHeight)
        ])
    }
    
    // MARK: - Public Methods
    func updateProgress(currentQuestion: Int, totalQuestions: Int) {
        questionCountLabel.text = "\(currentQuestion)/\(totalQuestions)"
        let progress = Float(currentQuestion) / Float(totalQuestions)
        progressBar.progress = progress
    }
    
    func updatePoints(points: Int) {
        pointsLabel.attributedText = .createPointsText(points: points)
    }
}

// MARK: - Attributed String
extension NSAttributedString {
    static func createPointsText(points: Int) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let pointsAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.FontSizes.small14, weight: .medium),
            .foregroundColor: Constants.Colors.yellowPrimary
        ]
        
        let starAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.FontSizes.small14, weight: .medium),
            .foregroundColor: Constants.Colors.yellowPrimary
        ]
        
        attributedString.append(NSAttributedString(string: "\(points) ", attributes: pointsAttributes))
        attributedString.append(NSAttributedString(string: "★", attributes: starAttributes))
        
        return attributedString
    }
}
