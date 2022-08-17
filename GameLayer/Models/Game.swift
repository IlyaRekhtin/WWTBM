//
//  Game.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import Foundation

final class Game {
    static let shared = Game()
    
    var gameSession: GameSession?
    private var service = GameCaretaker()
    private var gameResults = [GameSession]()
    
    private init() {
        self.gameResults = service.fetchSaveGameSession()
    }
    
    func saveGameResults(gameSession: GameSession) {
        self.gameResults.append(gameSession)
        self.service.saveGameSession(results: gameResults)
        self.gameSession = nil
        
    }
    
}
