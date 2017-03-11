//
//  ViewController.swift
//  Quiz1
//
//  Created by helloyako on 2016. 7. 13..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
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
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(sender: UIButton) {
        let answer = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
    
    func animateLabelTransitions() {
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
//        UIView.animateWithDuration(0.5,
//                                   delay: 0,
//                                   options: [UIViewAnimationOptions.CurveEaseInOut],
//                                   animations: {
//                                    self.currentQuestionLabel.alpha = 0
//                                    self.nextQuestionLabel.alpha = 1
//                                    
//                                    self.view.layoutIfNeeded()
//            },
//                                   completion: { _ in
//                                    swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
//                                    swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
//                                    
//                                    self.updateOffScreenLabel()
//        })
        
        UIView.animateWithDuration(0.5,
                                   delay: 0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 0.5,
                                   options: [], animations: {
                                    self.currentQuestionLabel.alpha = 0
                                    self.nextQuestionLabel.alpha = 1
                                    
                                    self.view.layoutIfNeeded()
            }
            , completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                
                self.updateOffScreenLabel()
        })
    }
}

