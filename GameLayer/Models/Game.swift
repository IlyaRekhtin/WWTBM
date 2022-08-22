//
//  Game.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import Foundation

final class Game {
    
    static let shared = Game()
    
    var difficulty: Difficulty {
        get{
            guard let data = UserDefaults.standard.data(forKey: "difficulty") else {return .easy}
            do {
                return try JSONDecoder().decode(Difficulty.self, from: data)
            } catch {
                print(error)
                return .easy
            }
        }
        set{
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: "difficulty")
            } catch {
                print(error)
            }
        }
    }
    var gameSession: GameSession?
    private var gameCaretaker = GameCaretaker()
    private var gameResults = [GameSession]()
    
    private init() {
        self.gameResults = gameCaretaker.fetchSaveGameSession()
    }
    
    func saveGameResults(gameSession: GameSession) {
        self.gameResults.append(gameSession)
        self.gameCaretaker.saveGameSession(results: gameResults)
        self.gameSession = nil
        
    }
    
}
