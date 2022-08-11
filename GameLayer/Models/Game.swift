//
//  Game.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import Foundation

final class Game {
    static let shared = Game()
    
    private init() {}
    
    var gameSession: GameSession?
    
    private var gameResults = [GameSession]()
    
    func addGameResults(gameSession: GameSession) {
        self.gameResults.append(gameSession)
    }
}
