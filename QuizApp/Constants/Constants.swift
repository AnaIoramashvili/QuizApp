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
    }
    
    struct FontSizes {
        static let small: CGFloat = 12
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
}

