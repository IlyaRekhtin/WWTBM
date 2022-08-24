//
//  SettingsViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 17.08.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let backgroundImage: UIImageView = {
        var backgroundImage = UIImageView(image: UIImage(named: "backgroundImageMain"))
        backgroundImage.contentMode = .scaleToFill
        return backgroundImage
    }()
    private let backgroundView: UIView = {
        var backgroundView = UIView(frame: .zero)
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.6
        return backgroundView
    }()
    
    private let gameOnTimeLable: UILabel = {
        var lable = UILabel()
        lable.text = "Вопросы на время"
        lable.textColor = .white
        lable.font = UIFont(name: "Times New Roman", size: 17)
        return lable
    }()
    
    private var gameOnTimeSwitch: UISwitch = {
        var gameOnTimeSwitch = UISwitch()
        gameOnTimeSwitch.isOn = Game.shared.difficulty == .easy ? false : true
        gameOnTimeSwitch.addAction(UIAction(handler: { _ in
            if gameOnTimeSwitch.isOn {
                Game.shared.difficulty = .hard
            } else {
                Game.shared.difficulty = .easy
            }
        }), for: .valueChanged)
        return gameOnTimeSwitch
    }()
    
    private let settingsStackView: UIStackView = {
        var settingsStackView = UIStackView(frame: .zero)
        settingsStackView.axis = .horizontal
        settingsStackView.spacing = 3
        settingsStackView.distribution = .fill
        settingsStackView.alignment = .center
        return settingsStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeConstraints()
        navigationBarSetup()
    }
}

//MARK: - Navigation appearance
private extension SettingsViewController {
    func navigationBarSetup() {
        self.navigationItem.title = "Настройки"
        
        self.navigationItem.standardAppearance = Appearance.navigationBarAppearance()
        self.navigationItem.compactAppearance = Appearance.navigationBarAppearance()
        self.navigationItem.scrollEdgeAppearance = Appearance.navigationBarAppearance()
        self.navigationItem.compactScrollEdgeAppearance = Appearance.navigationBarAppearance()
        
    }
}
//MARK: - snapKit
private extension SettingsViewController {
    func makeConstraints() {
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        self.backgroundImage.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        self.settingsStackView.addArrangedSubview(self.gameOnTimeLable)
        self.settingsStackView.addArrangedSubview(self.gameOnTimeSwitch)
        self.view.addSubview(settingsStackView)
        settingsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(300)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
    }
}
