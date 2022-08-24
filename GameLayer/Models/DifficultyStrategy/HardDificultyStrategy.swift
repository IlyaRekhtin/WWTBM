//
//  WWTBM
//
//  Created by Илья Рехтин on 17.08.2022.
//

import UIKit

final class HardDificultyStrategy: DifficultyProtocol {
    
    let careTaker = GameCaretaker(key: .questions)
    weak var timer: Timer!
    
    init(timer: Timer) {
        self.timer = timer
    }
    func getNextQuestion(for gameLevel: Int) -> Question? {
        if gameLevel <= 10 {
            let questions: [Question] = careTaker.fetchData().filter{$0.difficult == gameLevel}
            let random = Int.random(in: 0...questions.count - 1)
            return questions[random]
        } else {
            return nil
        }
    }
}
