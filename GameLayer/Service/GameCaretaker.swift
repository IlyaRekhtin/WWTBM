//
//  GameCaretaker.swift
//  WWTBM
//
//  Created by Илья Рехтин on 13.08.2022.
//

import Foundation

final class GameCaretaker {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "results"
    
    
    func saveGameSession(results: [GameSession]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    func fetchSaveGameSession() -> [GameSession] {
        guard let data = UserDefaults.standard.data(forKey: key) else {return []}
        do {
            return try self.decoder.decode([GameSession].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
