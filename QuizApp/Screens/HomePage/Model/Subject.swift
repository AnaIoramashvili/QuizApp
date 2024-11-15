//
//  Subject.swift
//  QuizApp
//
//  Created by Ana on 11/14/24.
//

import UIKit

struct Subject {
    let icon: UIImage
    let title: String
    let description: String
}

let subjects: [Subject] = [
    Subject(icon: UIImage(named: "geography")!, title: "გეოგრაფია", description: "აღწერა"),
    Subject(icon: UIImage(named: "programming")!, title: "პროგრამირება", description: "აღწერა"),
    Subject(icon: UIImage(named: "history")!, title: "ისტორია", description: "აღწერა"),
    Subject(icon: UIImage(named: "physics")!, title: "ფიზიკა", description: "აღწერა"),
    Subject(icon: UIImage(named: "geography")!, title: "გეოგრაფია", description: "აღწერა"),
    Subject(icon: UIImage(named: "programming")!, title: "პროგრამირება", description: "აღწერა"),
    Subject(icon: UIImage(named: "history")!, title: "ისტორია", description: "აღწერა"),
    Subject(icon: UIImage(named: "physics")!, title: "ფიზიკა", description: "აღწერა")
]
