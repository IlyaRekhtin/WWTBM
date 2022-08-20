//
//  GameViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import UIKit


class GameViewController: UIViewController {

    private var timer: Timer!
    private var runCount = 20 {
        didSet{
            self.timerLable.text = String(self.runCount)
        }
    }
    private var question: Question?
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
        return lable
    }()
    
    private let backgroundImage: UIImageView = {
        var backgroundImage = UIImageView(image: UIImage(named: "gameBackgroundImage"))
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
    private var answerButtonA: AnswerButton = {
        var answerButton = AnswerButton(frame: .zero)
        return answerButton
    }()
    
    private var answerButtonB: AnswerButton = {
        var answerButton = AnswerButton(frame: .zero)
        return answerButton
    }()
    
    private var answerButtonC: AnswerButton = {
        var answerButton = AnswerButton(frame: .zero)
        return answerButton
    }()
    
    private var answerButtonD: AnswerButton = {
        var answerButton = AnswerButton(frame: .zero)
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
        textView.alpha = 0.8
        textView.layer.cornerRadius = 17
        textView.textColor = .white
        textView.textAlignment = .center
        textView.font = UIFont(name: "Times New Roman", size: 20)
        textView.isEditable = false
        textView.isSelectable = false
        return textView
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

        self.question = self.difficultyGameStrategy.getNextQuestion(for: self.gameLevel.value)
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
    
    
    /// Действие при нажатии на кнопку выбора ответа
    @objc private func answerButtonAction(sender: AnswerButton) {
        ///достаем вопрос
        guard let question = question else {return}
        /// проверяем правильность ответа
        if question.answerIsCurrent(answer: sender.text) {
            /// если да переходим на следующий уровень,
            /// меняем титл навАйтема
            /// получаем новый вопрос
            self.gameLevel.value += 1
            self.currentAnswers += 1
            self.question = self.difficultyGameStrategy.getNextQuestion(for: self.gameLevel.value)
            setButtonText(for: self.question)
            self.runCount = 20
        } else {
            /// нет, выводим алерт
            sender.configuration?.baseBackgroundColor = .red
            if self.difficulty == .hard {
                self.timer.invalidate()
            }
            showAlert(title: "И... это не верный ответ!", messege: "правильный ответ \(question.currentAnswer)\n к сожалению вы проиграли!")
        }
    }
    
    /// функция утанавливает значения текствью и кнопок в соответвствии с переданным вопросом
    private func setButtonText(for question: Question?) {
        guard let question = question else {
            if self.difficulty == .hard {
                self.timer.invalidate()
            }
            showAlert(title: "ПОЗДРАВЛЯЮ!!!!", messege: "Теперь вы миллионер!!!")
            return
        }
        self.questionTextView.text = question.question
        self.answerButtonA.setAnswerText(text: question.answers[0], for: .a)
        self.answerButtonB.setAnswerText(text: question.answers[1], for: .b)
        self.answerButtonC.setAnswerText(text: question.answers[2], for: .c)
        self.answerButtonD.setAnswerText(text: question.answers[3], for: .d)
    }
    
    private func showAlert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .cancel, handler: { _ in
            self.delegate?.saveGameResults(currentAnswers: self.currentAnswers)
            self.navigationController?.popViewController(animated: false)
        }))
        self.present(alert, animated: true, completion: nil)
    }
  
  @objc private func fireTimer() {
        self.runCount -= 1
        
        if self.runCount == 0 {
            self.timer.invalidate()
            showAlert(title: "УВЫ...", messege: "Время вышло, Вы не успели дать правильный ответ😢")
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
            make.height.equalTo(250)
        }
        
        self.view.addSubview(questionTextView)
        self.questionTextView.snp.makeConstraints { make in
            make.bottom.equalTo(self.VStack.snp.top).offset(-5)
            make.right.left.equalToSuperview().inset(10)
            make.height.equalTo(100)
        }
        
        self.view.addSubview(timerLable)
        timerLable.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.bottom.equalTo(self.questionTextView.snp.top).inset(10)
            make.width.height.equalTo(60)
        }
    }
}

//MARK: - Navigation appearance
private extension GameViewController {
    func navigationBarSetup() {
        self.navigationItem.title = "Вопрос №\(self.gameLevel.value)"
        
        let navBarAppearance = UINavigationBarAppearance()
        
        // bacground
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.5, alpha: 0.8)
                
        //title
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        // all button
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navBarAppearance.buttonAppearance = barButtonItemAppearance
        navBarAppearance.backButtonAppearance = barButtonItemAppearance
        navBarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        
        // right bar button
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(rightBarButtonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.navigationItem.standardAppearance = navBarAppearance
        self.navigationItem.compactAppearance = navBarAppearance
        self.navigationItem.scrollEdgeAppearance = navBarAppearance
        self.navigationItem.compactScrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func rightBarButtonAction() {
        self.navigationController?.popViewController(animated: true)
        // to do выплывающее меню со списком выйгранной суммы и подсказками
    }
}
