//
//  CallFriendButton.swift
//  WWTBM
//
//  Created by Илья Рехтин on 22.08.2022.
//

import UIKit

class PromptButton: UIButton {

    private var config: UIButton.Configuration = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.buttonSize = .large
        config.baseForegroundColor = UIColor.white
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        return config
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configuration = config
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = self.frame.width / 3
        self.clipsToBounds = true
    }
    
    
    convenience init(_ title: String) {
        self.init(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        self.configuration?.title = title
    }
    
    convenience init(_ image: UIImage) {
        self.init(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        self.configuration?.image = image
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
