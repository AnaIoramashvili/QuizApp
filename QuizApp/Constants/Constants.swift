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
        static let backgroundImageHeight: CGFloat = 433
        static let illustrationImageWidth: CGFloat = 229
        static let illustrationImageHeight: CGFloat = 229
        static let textFieldHeight: CGFloat = 44
        static let startButtonLeadingPadding: CGFloat = 117
        static let startButtonTrailingPadding: CGFloat = 117
        static let startButtonWidth: CGFloat = 141
        static let startButtonHeight: CGFloat = 44
        
        // Spacing and Padding
        static let titleLabelTopPadding: CGFloat = 121
        static let illustrationTopPadding: CGFloat = 181
        static let illustrationLeadingPadding: CGFloat = 73
        static let textFieldTopPadding: CGFloat = 115
        static let textFieldHorizontalPadding: CGFloat = 54
        static let startButtonTopPadding: CGFloat = 26
    }
}

