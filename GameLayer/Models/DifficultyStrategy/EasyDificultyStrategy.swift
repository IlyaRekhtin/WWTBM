//

//  WWTBM
//
//  Created by Илья Рехтин on 17.08.2022.
//

import Foundation

final class EasyDificultyStrategy: DifficultyProtocol {
    let careTaker = GameCaretaker(key: .questions)
    
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