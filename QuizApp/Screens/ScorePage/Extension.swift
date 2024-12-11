//
//  Extension.swift
//  QuizApp
//
//  Created by Ana on 11/28/24.
//

import UIKit

// MARK: - Attributed String for header Label
extension NSAttributedString {
    //Header Text
    static func createHeaderText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.FontSizes.medium),
            .foregroundColor: Constants.Colors.neutralDarkGrey
        ]
        
        let starAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.FontSizes.medium),
            .foregroundColor: Constants.Colors.yellowPrimary
        ]
        
        attributedString.append(NSAttributedString(string: "დაგროვილი ქულები ", attributes: textAttributes))
        attributedString.append(NSAttributedString(string: "★", attributes: starAttributes))
        
        return attributedString
    }
    
    //EmptyState Text
    static func createEmptyStateText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        paragraphStyle.lineSpacing = 8
        
        let emojiAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18),
            .paragraphStyle: paragraphStyle
        ]
        
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: Constants.FontSizes.medium),
            .foregroundColor: Constants.Colors.neutralDarkGrey,
            .paragraphStyle: paragraphStyle
        ]
        
        attributedString.append(NSAttributedString(string: "🧐\n", attributes: emojiAttributes))
        attributedString.append(NSAttributedString(string: "სამწუხაროდ,\nქულები ჯერ არ გაქვს\nდაგროვილი.", attributes: textAttributes))
        
        return attributedString
    }
}


// MARK: - Layout Constants
extension ScorePageViewController {
    enum Layout {
        enum Header {
            static let topPadding: CGFloat = Constants.HomePageConstants.headerTopPadding
            static let leadingPadding: CGFloat = 99
        }
        
        enum BackButton {
            static let leadingPadding: CGFloat = 16
            static let topPadding: CGFloat = Constants.HomePageConstants.headerTopPadding
            static let width: CGFloat = 11
            static let height: CGFloat = 19
        }
        
        enum TableView {
            static let topPadding: CGFloat = Constants.HomePageConstants.tableViewTopPadding
        }
        
        enum BottomSeparator {
            static let height: CGFloat = Constants.HomePageConstants.bottomSeparatorLine
            static let bottomPadding: CGFloat = Constants.HomePageConstants.bottomSeparatorLinePadding
        }
        
        enum LogOutButton {
            static let leadingPadding: CGFloat = Constants.HomePageConstants.logOutButtonLeadingPadding
            static let bottomPadding: CGFloat = Constants.HomePageConstants.logoutButtonBottomPadding
            static let width: CGFloat = Constants.HomePageConstants.logoutButtonWidth
            static let height: CGFloat = Constants.HomePageConstants.logoutButtonHeight
        }
    }
}
