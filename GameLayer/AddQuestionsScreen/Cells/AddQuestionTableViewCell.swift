//
//  AddQuestionTableViewCell.swift
//  WWTBM
//
//  Created by Илья Рехтин on 21.08.2022.
//

import UIKit

final class AddQuestionTableViewCell: UITableViewCell, UITextFieldDelegate, UITextViewDelegate {
    static let reuseID = "add questions cell"
    
    var questionTextView: UITextView = {
        var textView = UITextView()
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.textColor = .black
        textView.font = UIFont(name: "AppleMyungjo", size: 24)
        textView.textAlignment = .left
        return textView
    }()
    
    // Answers block
    var answerA: UITextField!
    var answerB: UITextField!
    var answerC: UITextField!
    var answerD: UITextField!
    
    private var answerALable: UILabel!
    private var answerBLable: UILabel!
    private var answerCLable: UILabel!
    private var answerDLable: UILabel!
    
    private var answerAhStack: UIStackView!
    private var answerBhStack: UIStackView!
    private var answerChStack: UIStackView!
    private var answerDhStack: UIStackView!
    
    private let lableForSegmentedControl: UILabel = {
        let lable = UILabel()
        lable.text = "Правильный вариант ответа"
        lable.textColor = .black
        lable.font = UIFont(name: "AppleMyungjo", size: 17)
        lable.textAlignment = .center
        return lable
    }()
    var segmentedControl: UISegmentedControl = {
        var segmentedControl = UISegmentedControl(items: ["A", "B", "C", "D"])
        return segmentedControl
    }()
    
    
    // Difficult block
    private let lableDiffSlider: UILabel = {
        let lable = UILabel()
        lable.text = "Определите сложность вопроса"
        lable.textColor = .black
        lable.font = UIFont(name: "AppleMyungjo", size: 17)
        lable.textAlignment = .center
        return lable
    }()
    private var difficultSlider: UISlider = {
        var slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.value = slider.minimumValue
        return slider
    }()
    var difficultValueLable: UILabel = {
        var lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont(name: "AppleMyungjo", size: 17)
        lable.layer.borderColor = UIColor.black.cgColor
        lable.layer.borderWidth = 1
        lable.layer.cornerRadius = 10
        lable.textAlignment = .center
        return lable
    }()
    private var difficulthStack: UIStackView!
    
    private let vStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
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
        
        self.difficultValueLable.text = "1"
        self.difficulthStack = configurationHStackView()
        self.difficultSlider.addTarget(self, action: #selector(actionForDiffSlider(sender:)), for: .valueChanged)
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
        lable.text = variant.rawValue + ":"
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
    
    @objc private func actionForDiffSlider(sender: UISlider) {
        let sliderValue = roundingSliderValueToInt(number: sender.value)
        sender.setValue(Float(sliderValue), animated: false)
        self.difficultValueLable.text = String(sliderValue)
    }
    
    private func roundingSliderValueToInt(number: Float) -> Int {
        let remainder:Double = Double(1 - Int(number))
        return remainder > 0.5 ? Int(number) + 1 : Int(number)
    }
    
    
}


//MARK: - snap kit
private extension AddQuestionTableViewCell {
    func makeConstraints() {
        self.answerAhStack.addArrangedSubview(answerALable)
        self.answerAhStack.addArrangedSubview(answerA)
        
        self.answerBhStack.addArrangedSubview(answerBLable)
        self.answerBhStack.addArrangedSubview(answerB)
        
        self.answerChStack.addArrangedSubview(answerCLable)
        self.answerChStack.addArrangedSubview(answerC)
        
        self.answerDhStack.addArrangedSubview(answerDLable)
        self.answerDhStack.addArrangedSubview(answerD)
        
        self.difficulthStack.addArrangedSubview(self.difficultSlider)
        self.difficulthStack.addArrangedSubview(self.difficultValueLable)
        
        self.vStack.addArrangedSubview(questionTextView)
        questionTextView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(100)
        }
        self.vStack.addArrangedSubview(answerAhStack)
        answerA.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(30)
        }
        answerALable.snp.makeConstraints { make in
            make.width.equalTo(self.answerA.snp.height)
        }
        
        self.vStack.addArrangedSubview(answerBhStack)
        answerB.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(30)
        }
        answerBLable.snp.makeConstraints { make in
            make.width.equalTo(self.answerB.snp.height)
        }
        
        self.vStack.addArrangedSubview(answerChStack)
        answerC.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(30)
        }
        answerCLable.snp.makeConstraints { make in
            make.width.equalTo(self.answerC.snp.height)
        }
        
        self.vStack.addArrangedSubview(answerDhStack)
        answerD.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(30)
        }
        answerDLable.snp.makeConstraints { make in
            make.width.equalTo(self.answerD.snp.height)
        }
        
        self.vStack.addArrangedSubview(lableForSegmentedControl)
        self.vStack.addArrangedSubview(segmentedControl)
        self.segmentedControl.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(40)
        }
        
        self.vStack.addArrangedSubview(lableDiffSlider)
        
        self.difficultValueLable.snp.makeConstraints { make in
            make.width.equalTo(40)
        }
        
        self.vStack.addArrangedSubview(difficulthStack)
        
        
        self.contentView.addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview().inset(5)
        }
        
    }
}
