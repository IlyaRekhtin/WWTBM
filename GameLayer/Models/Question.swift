//
//  Question.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import Foundation

struct Question {
    var question: String
    var answers:[String]
    var currentAnswer: String
    var difficult: Int
    
    func answerIsCurrent(answer: String) -> Bool {
        answer == self.currentAnswer ? true : false
    }
}
