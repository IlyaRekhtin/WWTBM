//
//  DifficultyProtocol.swift
//  WWTBM
//
//  Created by Илья Рехтин on 17.08.2022.
//

import Foundation

protocol DifficultyProtocol {
    func getNextQuestion(for gameLevel: Int) -> Question?
}
