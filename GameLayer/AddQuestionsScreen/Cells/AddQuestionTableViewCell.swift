//
//  AddQuestionTableViewCell.swift
//  WWTBM
//
//  Created by Илья Рехтин on 21.08.2022.
//

import UIKit

final class AddQuestionTableViewCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {
    static let reuseID = "add questions cell"
    
    private var questionTextView: UITextView = {
        var textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.textColor = .black
        textView.font = UIFont(name: "AppleMyungjo", size: 18)
        textView.textAlignment = .left
        return textView
    }()
    
    // Answers block
    private var answerA: UITextField!
    private var answerB: UITextField!
    private var answerC: UITextField!
    private var answerD: UITextField!
    
    private var answerALable: UILabel!
    private var answerBLable: UILabel!
    private var answerCLable: UILabel!
    private var answerDLable: UILabel!
    
    private var answerAhStack: UIStackView!
    private var answerBhStack: UIStackView!
    private var answerChStack: UIStackView!
    private var answerDhStack: UIStackView!
    
    
    
    // Difficult block
    private var difficultSlider: UISlider = {
        var slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = slider.minimumValue
        return slider
    }()
    
    private let vStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configurationCell()
        self.questionTextView.delegate = self
        self.answerA.delegate = self
        self.answerB.delegate = self
        self.answerC.delegate = self
        self.answerD.delegate = self
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationCell() {
        self.answerA = configurateNewAnswerTextField()
        self.answerB = configurateNewAnswerTextField()
        self.answerC = configurateNewAnswerTextField()
        self.answerD = configurateNewAnswerTextField()
        
        self.answerALable = configurationAnswersLable(variant: .a)
        self.answerBLable = configurationAnswersLable(variant: .b)
        self.answerCLable = configurationAnswersLable(variant: .c)
        self.answerDLable = configurationAnswersLable(variant: .d)
        
        self.answerAhStack = configurationHStackView()
        self.answerBhStack = configurationHStackView()
        self.answerChStack = configurationHStackView()
        self.answerDhStack = configurationHStackView()
    }
    
    private func configurateNewAnswerTextField() -> UITextField{
        let textField = UITextField()
        textField.indent(size: 5)
        textField.textColor = .black
        textField.font = UIFont(name: "AppleMyungjo", size: 17)
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .black
        return textField
    }
    
    private func configurationAnswersLable(variant: VariantAnswer) -> UILabel {
        let lable = UILabel()
        lable.text = variant.rawValue
        lable.textColor = .black
        lable.font = UIFont(name: "AppleMyungjo", size: 17)
        lable.textAlignment = .right
        return lable
    }
    
    private func configurationHStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }
}


//MARK: - snap kit
private extension AddQuestionTableViewCell {
    func makeConstraints() {
        self.contentView.addSubview(questionTextView)
        questionTextView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(5)
            make.height.equalTo(100)
        }
        
        self.answerAhStack.addArrangedSubview(answerALable)
        self.answerAhStack.addArrangedSubview(answerA)
        
        self.answerBhStack.addArrangedSubview(answerBLable)
        self.answerBhStack.addArrangedSubview(answerB)
        
        self.answerChStack.addArrangedSubview(answerCLable)
        self.answerChStack.addArrangedSubview(answerC)
        
        self.answerDhStack.addArrangedSubview(answerDLable)
        self.answerDhStack.addArrangedSubview(answerD)
        
        self.vStack.addArrangedSubview(answerAhStack)
        self.vStack.addArrangedSubview(answerBhStack)
        self.vStack.addArrangedSubview(answerChStack)
        self.vStack.addArrangedSubview(answerDhStack)
        
        answerALable.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        answerBLable.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        answerCLable.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        answerDLable.snp.makeConstraints { make in
            make.width.equalTo(30)
        }
        
        answerA.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        answerB.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        answerC.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        answerD.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        self.contentView.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.equalTo(self.questionTextView.snp.bottom).offset(5)
            make.right.left.equalToSuperview().inset(5)
        }
        
        self.contentView.addSubview(self.difficultSlider)
        self.difficultSlider.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(5)
            make.top.equalTo(self.vStack.snp.bottom)
            make.bottom.equalToSuperview().inset(5)
            make.height.equalTo(40)
        }
        
        
    }
}
