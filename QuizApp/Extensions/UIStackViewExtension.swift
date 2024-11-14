//
//  StackViewExtension.swift
//  QuizApp
//
//  Created by Ana on 11/13/24.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
