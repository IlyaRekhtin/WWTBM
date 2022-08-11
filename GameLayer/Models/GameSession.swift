//
//  GameSession.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import Foundation
import UIKit

final class GameSession {
    
    private var gameDate: String
    private var currentAnswersCount = 0
    private var totalPriceWin = 0
    private var gameLevel = 1
    
    init() {
        let date = Date.now.description
        self.gameDate = date
    }
    
    func addGameLevel() {
        self.currentAnswersCount += 1
        self.gameLevel += 1
    }
    
    func getGameLevel() -> Int{
        self.gameLevel
    }
    
    func increaseTotalPrice(gameLevel: Int) {
        switch DataManager.Price(rawValue: gameLevel) {
        case .one:
            self.totalPriceWin = 1000
        case .two:
            self.totalPriceWin = 2000
        case .thee:
            self.totalPriceWin = 5000
        case .four:
            self.totalPriceWin = 10000
        case .five:
            self.totalPriceWin = 50000
        case .six:
            self.totalPriceWin = 100000
        case .seven:
            self.totalPriceWin = 200000
        case .eght:
            self.totalPriceWin = 500000
        case .nine:
            self.totalPriceWin = 750000
        case .ten:
            self.totalPriceWin = 1000000
        case .none:
            self.totalPriceWin = 0
        }
    }
}
