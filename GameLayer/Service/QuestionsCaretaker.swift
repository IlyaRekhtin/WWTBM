//
//  QuestionsCaretaker.swift
//  WWTBM
//
//  Created by Илья Рехтин on 22.08.2022.
//

import Foundation

final class QuestionsCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "questions"
    
    
    func saveQuestions(results: [Question]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    func fetchQuestions() -> [Question] {
        guard let data = UserDefaults.standard.data(forKey: key) else {return []}
        do {
            return try self.decoder.decode([Question].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
