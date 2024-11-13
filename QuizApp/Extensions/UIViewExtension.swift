//
//  UIViewExtension.swift
//  QuizApp
//
//  Created by Ana on 11/12/24.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
