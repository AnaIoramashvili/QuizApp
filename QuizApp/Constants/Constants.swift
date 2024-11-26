//
//  Constants.swift
//  QuizApp
//
//  Created by Ana on 11/12/24.
//

import UIKit

struct Constants {
    
    struct Images {
        static let backgroundShape = "backgroundShape"
        static let studentIllustration = "student_illustration"
        static let nextArrow = "next_arrow"
        static let arrowButton = "arrow"
        static let logOutButton = "logOut"
    }
    
    struct Label {
        static let labelText = "ჩემი პირველი ქვიზი"
        static let startButtonText = "ქვიზის დაწყება"
        static let placeholderText = "შეიყვანე სახელი"
    }
    
    struct Colors {
        static let buttonColor = UIColor(hex: "#FFC44A")
        static let borderColor = UIColor(hex: "#FFC44A")
        static let neutralWhite: UIColor = .white
        static let neutralGrey = UIColor(hex: "#B3B3B3")
        static let neutralLighterGray = UIColor(hex: "#F6F6F6")
        static let neutralLighterGray2 = UIColor(hex: "#F1F1F1")
        static let neutralDarkGrey = UIColor(hex: "#1D1D1D")
        static let yellowPrimary = UIColor(hex: "#FFC44A")
        static let blueSecondaryDefault = UIColor(hex: "#537FE7")
        static let blueSecondaryLighter = UIColor(hex: "#6B91EA")
        static let blueSecondaryLightest = UIColor(hex: "#C0D0F6")
    }
    
    struct FontSizes {
        static let small: CGFloat = 12
        static let small14: CGFloat = 14
        static let medium: CGFloat = 16
        static let big: CGFloat = 20
    }
    
    struct Layout {
        // Corner Radius
        static let textFieldCornerRadius: CGFloat = 12
        static let startButtonCornerRadius: CGFloat = 12
        static let gpaViewCornerRadius: CGFloat = 26
        static let gpaClearViewCornerRadius: CGFloat = 14
        static let containerCornerRadius: CGFloat = 26
        static let setupButtonCornerRadius: CGFloat = 22.5
        
        // Border Widths
        static let textFieldBorderWidth: CGFloat = 1
        
        // Heights and Widths
        static let backgroundImageTopAnchor: CGFloat = 0
        static let backgroundImageHeightMultiplier: CGFloat = 0.5
        static let keyboardAdjustmentOffset: CGFloat = -150
        static let textFieldHeight: CGFloat = 44
        static let startButtonLeadingPadding: CGFloat = 117
        static let startButtonTrailingPadding: CGFloat = 117
        static let startButtonHeight: CGFloat = 44
        
        // Spacing and Padding
        static let titleLabelTopPadding: CGFloat = 121
        static let illustrationTopPadding: CGFloat = 34
        static let illustrationLeadingPadding: CGFloat = 73
        static let illustrationTrailingPadding: CGFloat = -73
        static let illustrationBottomPadding: CGFloat = -23
        static let textFieldTopPadding: CGFloat = 115
        static let textFieldHorizontalPadding: CGFloat = 54
        static let startButtonTopPadding: CGFloat = 26
        static let backgroundBottom: CGFloat = 92
    }
    
    struct HomePageConstants {
        // Heights and Widths
        static let gpaViewHeight: CGFloat = 75
        static let gpaClearViewHeight: CGFloat = 40
        static let nextArrowHeight: CGFloat = 10
        static let nextArrowWidth: CGFloat = 14
        static let customRoundedButtonWidth: CGFloat = 20
        static let customRoundedButtonHeight: CGFloat = 20
        
        // Spacing and Padding
        static let headerTopPadding: CGFloat = 8
        static let horizontalPadding: CGFloat = 16
        static let gpaViewTopPadding: CGFloat = 20
        static let gpaClearViewLeadingPadding: CGFloat = 18
        static let gpaStackViewPadding: CGFloat = 12
        static let gpaStackViewSpacing: CGFloat = 4
        static let detailsButtonTrailingPadding: CGFloat = -48
        static let nextArrowTrailingPadding: CGFloat = -34
        static let subjectsLabelTopPadding: CGFloat = 32
        static let tableViewTopPadding: CGFloat = 16
        static let arrowButtonHeight: CGFloat = 45
        static let arrowButtonWidth: CGFloat = 45
        static let bottomSeparatorLine: CGFloat = 1
        static let bottomSeparatorLinePadding: CGFloat = -65
        static let logOutButtonLeadingPadding: CGFloat = 317
        static let logoutButtonBottomPadding: CGFloat = -11
        static let logoutButtonHeight: CGFloat = 43
        static let logoutButtonWidth: CGFloat = 43
    
        //Text
        static let helloText = "გამარჯობა, ირაკლი"
        static let chooseSubject = "აირჩიე საგანი"
        static let gpaText = "GPA -"
        static let gpaDigit = "4.0"
        static let detailsButtonText = "დეტალურად"
    }
    
    struct SubjectTableViewCellConstants {
        static let identifier = "SubjectCell"
        
        // Heights and Widths
        static let containerHeight: CGFloat = 106
        static let iconSize: CGFloat = 64
        
        // Spacing and Padding
        static let containerVerticalPadding: CGFloat = 6
        static let containerHorizontalPadding: CGFloat = 16
        static let iconLeadingPadding: CGFloat = 26
        static let titleTopPadding: CGFloat = 35
        static let labelLeadingPadding: CGFloat = 12
        static let descriptionTopPadding: CGFloat = 2
        static let arrowTrailingPadding: CGFloat = -26
    }
    
    struct QuizHeaderViewConstants {
        static let closeButtonImage = "close"
        static let closeButtonHeight: CGFloat = 16
        static let closeButtonWidth: CGFloat = 16
        static let leadingSpacerView: CGFloat = 24
    }
    
    struct QuizProgressViewConstants {
        static let radius: CGFloat = 4
        static let progressBarHeight: CGFloat = 9
        static let pointsStackSpacing: CGFloat = 4
        static let mainStackSpacing: CGFloat = 8
        static let starImageHeight: CGFloat = 8
        static let starImage = "star"
        static let currentScore = "მიმდინარე ქულა:"
    }
    
    struct QuizQuestionViewConstants {
        static let radius: CGFloat = 26
        static let height: CGFloat = 103
        static let sidePadding: CGFloat = 56
        static let numberOfLines: Int = 0
        static let questionViewHeight = 35
    }
    
    struct QuizViewControllerConstants {
        static let identifier = "AnswerCell"
        static let answerCellHeight: CGFloat = 72
        static let nextButtonRadius: CGFloat = 22
        static let nextButtonTitle = "შემდეგი"
        static let nextButtonHeight: CGFloat = 56
        
        static let mainStackViewSpacing: CGFloat = 24
        static let mainStackViewTopPadding: CGFloat = 8
        static let mainStackViewHorizontalPadding: CGFloat = 16
        static let answersTableViewTopPadding: CGFloat = 58
        static let answersTableViewHorizontalPadding: CGFloat = 16
        static let answersTableViewHeight: CGFloat = 300
        static let nextButtonTopPadding: CGFloat = 63
        static let nextButtonHorizontalPadding: CGFloat = 16
        static let heightForRow: CGFloat = 72
    }
    
    struct AnswerCellConstants {
        static let containerCornerRadius: CGFloat = 22
        static let containerVerticalPadding: CGFloat = 6
        static let containerHeight: CGFloat = 60
        static let titleLabelHorizontalPadding: CGFloat = 16
        static let starImageHeight: CGFloat = 12
        static let scoreLabel = "+1"
        static let scoreLabelPadding: CGFloat = -2
        
        static let success = UIColor(hex: "#4BB543")
        static let wrong = UIColor(hex: "#DB1D2A")
    }
}

