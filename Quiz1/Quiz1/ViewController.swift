//
//  ViewController.swift
//  Quiz1
//
//  Created by helloyako on 2016. 7. 13..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    let questions = ["From what is cognac mad?",
                     "What is 7+7",
                     "What is the capital of Vermont?"]
    let answers = ["Grapes",
                  "14",
                  "Montpelier"]
    var currentQuestionIndex = 0
    
    @IBAction func showNextQuestion(sender: UIButton) {
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question = questions[currentQuestionIndex]
        questionLabel.text = question
        answerLabel.text = "???"
        
    }
    
    @IBAction func showAnswer(sender: UIButton) {
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex]
    }
}

