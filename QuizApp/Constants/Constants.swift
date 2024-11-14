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
    }
    
    struct FontSizes {
        static let titleFontSize: CGFloat = 20
        static let buttonFontSize: CGFloat = 12
        static let textFieldFontSize: CGFloat = 12
    }
    
    struct Layout {
        // Corner Radius
        static let textFieldCornerRadius: CGFloat = 12
        static let startButtonCornerRadius: CGFloat = 12
        
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
}

