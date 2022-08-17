//
//  GameSession.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import Foundation
import UIKit

final class GameSession: Codable {
    
    private var gameDate: String
    private var totalPriceWin = 0
    private var currentAnswersCount = 0
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        self.gameDate = dateFormatter.string(from: Date.now)
        
    }
    
    func getGameDate() -> String {
        self.gameDate
    }
    
    func getGameTotalPrice() -> Int {
        self.totalPriceWin
    }
    
    func getcurrentAnswersCount() -> Int {
        self.currentAnswersCount
    }
    
    func setCurrentAnswersCountValue(value: Int) {
        self.currentAnswersCount = value
        increaseTotalPrice(currentAnswersCount: value)
    }
    
    private func increaseTotalPrice(currentAnswersCount: Int) {
        switch DataManager.Price(rawValue: currentAnswersCount) {
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
