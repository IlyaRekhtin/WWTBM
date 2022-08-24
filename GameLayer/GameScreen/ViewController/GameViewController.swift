//
//  GameViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import UIKit


class GameViewController: UIViewController {
    
    /// таймер ответа на вопрос на сложном уровне игры
    private var timer: Timer!
    private var runCount = 20 {
        didSet{
            self.timerLable.text = String(self.runCount)
        }
    }
    private var question: Question? {
        /// возвращвем синий цвет кнопкам после 50 на 50
        willSet{
            self.answerButtonA.configuration?.baseBackgroundColor = .systemBlue
            self.answerButtonB.configuration?.baseBackgroundColor = .systemBlue
            self.answerButtonC.configuration?.baseBackgroundColor = .systemBlue
            self.answerButtonD.configuration?.baseBackgroundColor = .systemBlue
        }
    }
    private var gameLevel = Observable<Int>(1)
    private var currentAnswers = 0
    var delegate: SaveGameSessionProgressProtocol?
    var difficulty: Difficulty = .easy
    var difficultyGameStrategy: DifficultyProtocol {
        switch self.difficulty {
        case .easy:
            self.timerLable.isHidden = true
            return EasyDificultyStrategy()
        case .hard:
            self.timerLable.isHidden = false
            return HardDificultyStrategy(timer: self.timer)
        }
    }
    
    private var timerLable: UILabel = {
        let lable = UILabel()
        lable.textColor = .white
        lable.font = UIFont(name: "Times New Roman", size: 28)
        lable.textAlignment = .center
        return lable
    }()
    
    private let backgroundImage: UIImageView = {
        var backgroundImage = UIImageView(image: UIImage(named: "gameBackgroundImage"))
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
    private var answerButtonA: AnswerButton = {
        var answerButton = AnswerButton(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        return answerButton
    }()
    
    private var answerButtonB: AnswerButton = {
        var answerButton = AnswerButton(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        return answerButton
    }()
    
    private var answerButtonC: AnswerButton = {
        var answerButton = AnswerButton(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        return answerButton
    }()
    
    private var answerButtonD: AnswerButton = {
        var answerButton = AnswerButton(frame: CGRect(x: 0, y: 0, width: 70, height: 45))
        return answerButton
    }()
    
    private let topHStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private let bottonHStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private let VStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    private var questionTextView: UITextView = {
        var textView = UITextView()
        textView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        textView.backgroundColor = .lightGray
        textView.layer.cornerRadius = 17
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 1
        textView.clipsToBounds = true
        textView.textColor = .white
        textView.textAlignment = .center
        textView.font = UIFont(name: "Times New Roman", size: 20)
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()
    
    private let callFriendButton: PromptButton = {
        var button = PromptButton(UIImage(systemName: "phone.and.waveform")!)
        return button
    }()
    
    private let buttonFor50to50: PromptButton = {
        var button = PromptButton("50 : 50")
        return button
    }()
    
    private let auditoryHelpButton: PromptButton = {
        var button = PromptButton(UIImage(systemName: "person.3.fill")!)
        return button
    }()
    
    private let usageStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.difficulty == .hard {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        }
        
        self.timerLable.text = String(self.runCount)
        navigationBarSetup()
        makeConstraints()
        addTargetForAnswerButton()
        addTargetForPromptButtons()
        
        self.question = self.difficultyGameStrategy.getNextQuestion(for: self.gameLevel.value)
        guard let question = question else {return}
        Game.shared.gameSession?.hintUsageFacade = HintUsageFacade(question)
        
        setButtonText(for: self.question)
        
        self.gameLevel.addObserver(self, options: [.new]) { [weak self] (gameLevel, _) in
            self?.navigationItem.title = "Вопрос №\(gameLevel)"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.difficulty == .hard, self.timer != nil {
            self.timer.invalidate()
        }
        
    }
    private func addTargetForAnswerButton() {
        self.answerButtonA.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
        self.answerButtonB.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
        self.answerButtonC.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
        self.answerButtonD.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func addTargetForPromptButtons(){
        self.callFriendButton.addTarget(self, action: #selector(actionForPromtButtons), for: .touchUpInside)
        self.buttonFor50to50.addTarget(self, action: #selector(actionForPromtButtons), for: .touchUpInside)
        self.auditoryHelpButton.addTarget(self, action: #selector(actionForPromtButtons), for: .touchUpInside)
    }
    
    @objc private func actionForPromtButtons(sender: UIButton) {
        
        let answersButtons = [self.answerButtonA, self.answerButtonB, self.answerButtonC, self.answerButtonD]
        
        if sender == self.callFriendButton  {
            Game.shared.gameSession?.hintUsageFacade?.callFriend(clouser: { [weak self] results in
                var name = ""
                ///алерт ввода имени
                let alert = UIAlertController(title: "Кому звоним?", message: "", preferredStyle: .alert)
                alert.addTextField() { textField in
                    textField.placeholder = "Введите имя друга"
                }
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in
                    guard let textField = alert.textFields?.first else {return}
                    if textField.text != "" {
                        name = textField.text!
                        ///алерт звонка
                        self?.showAlert(title: "Дозвонились!", messege: "\(name): Я думаю правильный ответ - \(results)", forExit: false)
                    } else {
                        self?.present(alert, animated: true, completion: nil)
                    }
                }))
                self?.present(alert, animated: true, completion: nil)
            })
            self.callFriendButton.isEnabled = false
        } else if sender == self.buttonFor50to50 {
            Game.shared.gameSession?.hintUsageFacade?.use50to50Hint(clouser: {results in
                guard let buttonOne = answersButtons.filter({$0.text == results[0]}).first,
                      let buttonTwo = answersButtons.filter({$0.text == results[1]}).first else {return}
                buttonOne.configuration?.baseBackgroundColor = .red
                buttonTwo.configuration?.baseBackgroundColor = .red
            })
            self.buttonFor50to50.isEnabled = false
        } else if sender == self.auditoryHelpButton {
            Game.shared.gameSession?.hintUsageFacade?.useAuditoryHelp(clouser: { results in
                showAlert(title: "Аудитория приняла решение!", messege: results, forExit: false)
            })
            self.auditoryHelpButton.isEnabled = false
        }
    }
    
    
    /// Действие при нажатии на кнопку выбора ответа
    @objc private func answerButtonAction(sender: AnswerButton) {
        ///достаем вопрос
        guard let question = self.question else {return}
        /// проверяем правильность ответа
        if question.answerIsCurrent(answer: sender.text) {
            /// если да переходим на следующий уровень,
            /// меняем титл навАйтема
            /// получаем новый вопрос
            self.gameLevel.value += 1
            self.currentAnswers += 1
            self.question = self.difficultyGameStrategy.getNextQuestion(for: self.gameLevel.value)
            guard let nextQuestion = self.question else {return}
            Game.shared.gameSession?.hintUsageFacade = HintUsageFacade(nextQuestion)
            setButtonText(for: self.question)
            self.runCount = 20
        } else {
            /// нет, выводим алерт
            sender.configuration?.baseBackgroundColor = .red
            if self.difficulty == .hard {
                self.timer.invalidate()
            }
            showAlert(title: "И... это не верный ответ!", messege: "правильный ответ \(question.currentAnswer)\n к сожалению вы проиграли!", forExit: true)
        }
    }
    
    /// функция утанавливает значения текствью и кнопок в соответвствии с переданным вопросом
    private func setButtonText(for question: Question?) {
        guard let question = question else {
            if self.difficulty == .hard {
                self.timer.invalidate()
            }
            showAlert(title: "ПОЗДРАВЛЯЮ!!!!", messege: "Теперь вы миллионер!!!", forExit: true)
            return
        }
        self.questionTextView.text = question.questionText
        
        guard let answerA = question.answers["A"],
              let answerB = question.answers["B"],
              let answerC = question.answers["C"],
              let answerD = question.answers["D"] else {return}
        
        self.answerButtonA.setAnswerText(text: answerA, for: .a)
        self.answerButtonB.setAnswerText(text: answerB, for: .b)
        self.answerButtonC.setAnswerText(text: answerC, for: .c)
        self.answerButtonD.setAnswerText(text: answerD, for: .d)
    }
    
    private func showAlert(title: String, messege: String, forExit: Bool) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .cancel, handler: { _ in
            if forExit {
                self.delegate?.saveGameResults(currentAnswers: self.currentAnswers)
                self.navigationController?.popViewController(animated: false)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func fireTimer() {
        self.runCount -= 1
        
        if self.runCount == 0 {
            self.timer.invalidate()
            showAlert(title: "УВЫ...", messege: "Время вышло, Вы не успели дать правильный ответ😢", forExit: true)
        }
    }
}

//MARK: - SnapKit
private extension GameViewController {
    func makeConstraints() {
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        
        self.topHStack.addArrangedSubview(answerButtonA)
        self.topHStack.addArrangedSubview(answerButtonB)
        
        self.bottonHStack.addArrangedSubview(answerButtonC)
        self.bottonHStack.addArrangedSubview(answerButtonD)
        
        self.VStack.addArrangedSubview(topHStack)
        self.VStack.addArrangedSubview(bottonHStack)
        
        self.view.addSubview(VStack)
        self.VStack.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        
        self.view.addSubview(questionTextView)
        self.questionTextView.snp.makeConstraints { make in
            make.bottom.equalTo(self.VStack.snp.top).offset(-5)
            make.right.left.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        self.usageStackView.addArrangedSubview(callFriendButton)
        self.usageStackView.addArrangedSubview(buttonFor50to50)
        self.usageStackView.addArrangedSubview(auditoryHelpButton)
        self.view.addSubview(usageStackView)
        usageStackView.snp.makeConstraints { make in
            make.bottom.equalTo(self.questionTextView.snp.top).offset(-5)
            make.right.left.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(timerLable)
        timerLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.usageStackView.snp.top).inset(10)
            make.width.height.equalTo(60)
        }
    }
}

//MARK: - Navigation appearance
private extension GameViewController {
    func navigationBarSetup() {
        self.navigationItem.title = "Вопрос №\(self.gameLevel.value)"
        
        self.navigationItem.standardAppearance = Appearance.navigationBarAppearance()
        self.navigationItem.compactAppearance = Appearance.navigationBarAppearance()
        self.navigationItem.scrollEdgeAppearance = Appearance.navigationBarAppearance()
        self.navigationItem.compactScrollEdgeAppearance = Appearance.navigationBarAppearance()
    }
}
