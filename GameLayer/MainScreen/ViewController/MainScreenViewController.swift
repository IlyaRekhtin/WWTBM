//
//  ViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import UIKit
import SnapKit

protocol SaveGameSessionProgressProtocol {
    func saveGameResults(currentAnswers: Int)
}

class MainScreenViewController: UIViewController {
    
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
    private let imageLable: UIImageView = {
        let imageLable = UIImageView(image: UIImage(named: "gameLable"))
        return imageLable
    }()
    private let startButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = "НАЧАТЬ ИГРУ"
        buttonConfiguration.cornerStyle = .large
        buttonConfiguration.baseBackgroundColor = .blue
        buttonConfiguration.baseForegroundColor = .white
        let startButton = UIButton(configuration: buttonConfiguration)
        return startButton
    }()
    private let recordsButton: UIButton = {
        var buttonConfiguration = UIButton.Configuration.plain()
        buttonConfiguration.title = "Рекорды"
        buttonConfiguration.cornerStyle = .small
        buttonConfiguration.baseForegroundColor = .white
        let recordsButton = UIButton(configuration: buttonConfiguration)
        return recordsButton
    }()
    private let buttonStackView: UIStackView = {
        var buttonStackView = UIStackView(frame: .zero)
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 20
        buttonStackView.distribution = .fill
        return buttonStackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        navigationBarSetup()
        startButtonAction()
        recordsButtonAction()
    }
  
    /// действие для кнопок главного меню
    private func startButtonAction() {
        startButton.addAction(UIAction(handler: { _ in
            Game.shared.gameSession = GameSession()
            let vc = GameViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    private func recordsButtonAction() {
        recordsButton.addAction(UIAction(handler: { _ in
            let vc = ResultsViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
    }
    
    
}

//MARK: - snapKit
private extension MainScreenViewController {
    func makeConstraints() {
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        self.backgroundImage.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        
        self.view.addSubview(imageLable)
        imageLable.snp.makeConstraints { make in
           
           
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-150)
        }
        
        self.buttonStackView.addArrangedSubview(startButton)
        self.buttonStackView.addArrangedSubview(recordsButton)
        self.view.addSubview(buttonStackView)
        buttonStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(130)
            make.height.equalTo(100)
        }
    }
}

//MARK: - Save game results protocol
extension MainScreenViewController: SaveGameSessionProgressProtocol {
    func saveGameResults(currentAnswers: Int) {
        guard let gameSession = Game.shared.gameSession else {return}
        gameSession.setCurrentAnswersCountValue(value: currentAnswers)
        Game.shared.saveGameResults(gameSession: gameSession)
    }
}

//MARK: - Navigation appearance
private extension MainScreenViewController {
    func navigationBarSetup() {
        self.navigationItem.backButtonTitle = "Выйти"
        self.navigationController?.navigationBar.tintColor = .white
    }
}
