//
//  GameCaretaker.swift
//  WWTBM
//
//  Created by Илья Рехтин on 13.08.2022.
//

import Foundation

final class GameCaretaker {
    //чтобы не вспоминать ключи
    enum Keys: String {
        case gameResults = "results"
        case questions = "questions"
    }
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private var key: String!
    
    init(key: Keys) {
        self.key = key.rawValue
    }
    
    func saveData<T:Codable>(data: [T]) {
        do {
            let data = try self.encoder.encode(data)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func fetchData<T: Codable>() -> [T] {
        guard let data = UserDefaults.standard.data(forKey: key) else {return []}
        do {
            return try self.decoder.decode([T].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
