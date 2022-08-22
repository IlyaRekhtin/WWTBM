//
//  QuestionsBuilder.swift
//  WWTBM
//
//  Created by Илья Рехтин on 22.08.2022.
//

import UIKit

final class QuestionsBuilder {
    private(set) var questionText: String = ""
    private(set) var answers:[String: String] = ["A": "", "B": "", "C": "", "D": ""]
    private(set) var currentAnswer: String = ""
    private(set) var difficult: Int = 1
    
    func build() -> Question {
        return Question(questionText: self.questionText, answers: self.answers, currentAnswer: self.currentAnswer, difficult: self.difficult)
    }
    
    func setQuestionText(_ questionText: String) {
        self.questionText = questionText
    }
    
    func setAnswers(_ answer: String, for variant: VariantAnswer) {
        switch variant {
        case .a:
            self.answers["A"] = answer
        case .b:
            self.answers["B"] = answer
        case .c:
            self.answers["C"] = answer
        case .d:
            self.answers["D"] = answer
        }
    }
    
    func setCurrentAnswer(_ currentAnswerIndex: Int) {
        
        var currentAnswerKey = ""
        
        switch currentAnswerIndex {
        case 0:
            currentAnswerKey = "A"
        case 1:
            currentAnswerKey = "B"
        case 2:
            currentAnswerKey = "C"
        case 3:
            currentAnswerKey = "D"
        default:
            currentAnswerKey = "A"
        }
        guard let currentAnswer = answers[currentAnswerKey] else {return}
        self.currentAnswer =  currentAnswer
    }
    
    func setDifficult(_ difficult: Int) {
        self.difficult = difficult
    }
}
