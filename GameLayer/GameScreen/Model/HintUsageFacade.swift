//
//  HintUsageFacade.swift
//  WWTBM
//
//  Created by Илья Рехтин on 22.08.2022.
//

import Foundation

final class HintUsageFacade {
    
    private var question: Question!
    
    init(_ question: Question) {
        self.question = question
    }
    init(from decoder: Decoder) throws {}
    
    
    func callFriend(clouser: (String) -> ()) {
        clouser(self.question.callFriend())
    }
    
    func useAuditoryHelp(clouser: (String) -> ()) {
        clouser(self.question.useAuditoryHelp())
    }
    
    func use50to50Hint(clouser: ([String]) -> ()) {
        clouser(self.question.use50to50Hint())
    }
}

extension HintUsageFacade: Codable {
    func encode(to encoder: Encoder) throws {}
}
