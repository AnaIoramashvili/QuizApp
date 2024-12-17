//
//  CurvedBackgroundView.swift
//  QuizApp
//
//  Created by Ana on 12/17/24.
//

import UIKit

final class CurvedBackgroundView: UIView {
    private let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        shapeLayer.fillColor = Constants.Colors.blueSecondaryDefault.cgColor
        layer.addSublayer(shapeLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
    
    private func updatePath() {
        let path = UIBezierPath()
        let curveHeight: CGFloat = 433
        let curveWidth: CGFloat = 375

        path.move(to: CGPoint(x: 0, y: 0))

        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: curveHeight - 220))
        
        let controlPoint = CGPoint(x: bounds.width, y: curveHeight)
        path.addQuadCurve(to: CGPoint(x: 0, y: curveHeight),
                         controlPoint: controlPoint)
        
        path.close()
        shapeLayer.path = path.cgPath
    }
}
