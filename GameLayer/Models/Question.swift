//
//  Question.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import UIKit

struct Question: Codable {
    var questionText: String
    var answers:[String: String] = ["A": "", "B": "", "C": "", "D": ""]
    var currentAnswer: String
    var difficult: Int
    
    func answerIsCurrent(answer: String) -> Bool {
        answer == self.currentAnswer ? true : false
    }
    
    // помощь друга
    func callFriend() -> String {
        self.currentAnswer
    }
    
    //помощь зала
    func useAuditoryHelp() -> String {
        let auditoryHelp = getRandonPocent()
        return "A:\(auditoryHelp[0])%\t\nB:\(auditoryHelp[1])%\t\nC:\(auditoryHelp[2])%\t\nD:\(auditoryHelp[3])%\t"
    }
    
    private func getRandonPocent() -> [Int] {
        var results = [Int]()
        // сто процентов аудитории
        var proc = 100
        /// разбивыаем 100 процентов на четыре случайных составляющих
        /// для последующему присваиванию этих составляющих вариантам ответов
        for _ in 1...3 {
            let random = Int.random(in: 0...proc)
            results.append(random)
            proc -= random
        }
        results.append(proc)
        return results
    }
    
    // 50 на 50
    func use50to50Hint() -> [String] {
        var results = [String]()
        // создаем массив с вариантами неправильных ответов
        for key in answers.keys {
            if let answer = answers[key] {
                if !answerIsCurrent(answer: answer) {
                    results.append(answer)
                }
            }
        }
        // случайное число (для случайного выбора из трех вариантов
        let random = Int.random(in: 0...2)
        /// удаляем один неверный ответ, на выходе массив с двумя
        /// случайными неправильными ответами
        results.remove(at: random)
        return results
    }
    
}
