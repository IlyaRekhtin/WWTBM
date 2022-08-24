//
//  AnswerButton.swift
//  WWTBM
//
//  Created by Илья Рехтин on 11.08.2022.
//

import UIKit

enum VariantAnswer: String {
     case a = "A"
     case b = "B"
     case c = "C"
     case d = "D"
 }

class AnswerButton: UIButton {
    
    var text: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        config.buttonSize = .large
        config.baseForegroundColor = UIColor.white
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        self.configuration = config
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.width / 3
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// функция добавляет к титлу кнопки вариант ответа 
    func setAnswerText(text: String, for variant: VariantAnswer ) {
        self.text = text
        self.configuration?.title = "\(variant.rawValue): \(text)"
    }
}
