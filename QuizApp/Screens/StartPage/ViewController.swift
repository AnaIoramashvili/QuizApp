//
//  ViewController.swift
//  QuizApp
//
//  Created by Ana on 11/19/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Uncomment the pop-up you want to test
         testCustomPopUp()
//        testFinalScorePopUp()
    }
    
    private func testCustomPopUp() {
        // Create an instance of the CustomPopUp
        let customPopUp = CustomPopUp()
        customPopUp.configure(question: "ნამდვილად გსურს გასვლა?")

        // Configure actions
        customPopUp.acceptButtonTap = {
            print("Accepted!")
        }
        customPopUp.rejectButtonTap = {
            print("Rejected!")
        }

        // Add the pop-up to the view
        addPopUpToView(customPopUp)
    }

    private func testFinalScorePopUp() {
        // Create an instance of the FinalScorePopUp
        let finalScorePopUp = ScorePopUp()
        finalScorePopUp.configure(points: 85)

        // Configure action
        finalScorePopUp.closeAction = {
            print("Close button clicked!")
        }

        // Add the pop-up to the view
        addPopUpToView(finalScorePopUp)
    }

    private func addPopUpToView(_ popUp: UIView) {
        view.addSubview(popUp)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            popUp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUp.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUp.widthAnchor.constraint(equalToConstant: 270),
            popUp.heightAnchor.constraint(equalToConstant: 176)
        ])
    }
}
