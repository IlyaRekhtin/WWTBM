//
//  GameViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 09.08.2022.
//

import UIKit


class GameViewController: UIViewController {

    private var question: Question?
    private var gameLevel = 1
    private var currentAnswers = 0
    var delegate: SaveGameSessionProgressProtocol?
    
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
        navigationBarSetup()
        makeConstraints()
        self.answerButtonA.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
        self.answerButtonB.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
        self.answerButtonC.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
        self.answerButtonD.addTarget(self, action: #selector(answerButtonAction(sender:)), for: .touchUpInside)
        
        self.question = getNextQuestion()
        setButtonText(for: self.question)
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
            self.gameLevel += 1
            self.navigationItem.title = "Вопрос №\(self.gameLevel)"
            self.currentAnswers += 1
            self.question = getNextQuestion()
            setButtonText(for: self.question)
        } else {
            /// нет, выводим алерт
            sender.configuration?.baseBackgroundColor = .red
            showAlert(title: "И... это не верный ответ!", messege: "правильный ответ \(question.currentAnswer)\n к сожалению вы проиграли!")
        }
    }
    
    private func getNextQuestion() -> Question? {
        if self.gameLevel <= 10 {
            let questions = DataManager.data.questions.filter {$0.difficult == self.gameLevel}
            let random = Int.random(in: 0...questions.count - 1)
            return questions[random]
        } else {
            showAlert(title: "ПОЗДРАВЛЯЮ!!!!", messege: "Теперь вы миллионер!!!")
            return nil
        }
    }
    
    /// функция утанавливает значения текствью и кнопок в соответвствии с переданным вопросом
    private func setButtonText(for question: Question?) {
        guard let question = question else {return}
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
    }
}

//MARK: - Navigation appearance
private extension GameViewController {
    func navigationBarSetup() {
        
        self.navigationItem.title = "Вопрос №\(self.gameLevel)"
        
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
        // to do выплывающее меню со списком выйгранной суммы и подсказками
    }
}
