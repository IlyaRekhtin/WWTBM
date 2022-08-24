//
//  Game.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import Foundation

final class Game {
    //singletone
    static let shared = Game()
    
    var gameSession: GameSession?
    private var gameCaretaker = GameCaretaker(key: .gameResults)
    private var gameResults = [GameSession]()
    var difficulty: Difficulty {
        get{
            getDifficalty()
        }
        set{
            saveDifficulty(newValue: newValue)
        }
    }
    
    private init() {
        // ранее сохраненные результаты
        self.gameResults = gameCaretaker.fetchData()
    }
    
    func saveGameResults(gameSession: GameSession) {
        self.gameResults.append(gameSession)
        self.gameCaretaker.saveData(data: gameResults)
        self.gameSession = nil
    }
}

//MARK: - private
extension Game {
    // получаем ранее сохраненную в настройках сложность игры, если нет то играем на easy
    private func getDifficalty() -> Difficulty {
        guard let data = UserDefaults.standard.data(forKey: "difficulty") else {return .easy}
        do {
            return try JSONDecoder().decode(Difficulty.self, from: data)
        } catch {
            print(error)
            return .easy
        }
    }
    //сохраняем сложность игры указанную в настройках
    private func saveDifficulty(newValue: Difficulty) {
        do {
            let data = try JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: "difficulty")
        } catch {
            print(error)
        }
    }
    
    
}

