//
//  AnswerButton.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import UIKit

class AnswerButton: UIButton {
    
    enum VariantAnswer: String {
        case a = "A: "
        case b = "B: "
        case c = "C: "
        case d = "D: "
    }
    
    var text = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var config = UIButton.Configuration.tinted()
        config.cornerStyle = .medium
        config.buttonSize = .large
        config.baseForegroundColor = UIColor.white
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAnswerText(text: String, for variant: VariantAnswer ) {
        self.text = text
        self.configuration?.title = variant.rawValue + text
    }
}