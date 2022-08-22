//
//  AddQuestionsViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 21.08.2022.
//

import UIKit

final class AddQuestionsViewController: UIViewController {
    
    private let caretaker = QuestionsCaretaker()
    
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
    private var tableView: UITableView!
    private let rowAddButton: UIButton = {
        var button = UIButton()
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.buttonSize = .large
        button.configuration?.baseForegroundColor = .black
        button.configuration?.image = UIImage(systemName: "plus.circle")
        return button
    }()
    
    private var builder = QuestionsBuilder()
    
    private var rowCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateTableView()
        navigationBarSetup()
        makeConstraints()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func configurateTableView() {
        self.tableView = UITableView()
        tableView.backgroundColor = .white
        self.tableView.register(AddQuestionTableViewCell.self, forCellReuseIdentifier: AddQuestionTableViewCell.reuseID)
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 60))
        footerView.addSubview(rowAddButton)
        self.tableView.tableFooterView = footerView
        self.rowAddButton.addTarget(self, action: #selector(rowAddButtonAction), for: .touchUpInside)
    }
    
    @objc private func rowAddButtonAction() {
        self.rowCount += 1
        self.tableView.reloadData()
    }
}

//MARK: - tableview delegate, datasource
extension AddQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: AddQuestionTableViewCell.reuseID, for: indexPath) as! AddQuestionTableViewCell
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - snap kit
private extension AddQuestionsViewController {
    func makeConstraints() {
        self.view.addSubview(backgroundImage)
        
        self.backgroundImage.addSubview(backgroundView)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.right.left.bottom.top.equalToSuperview()
        }
        
        rowAddButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

//MARK: - Navigation appearance
private extension AddQuestionsViewController {
    func navigationBarSetup() {
        
        self.navigationItem.backButtonDisplayMode = .minimal
        
        
        let navBarAppearance = UINavigationBarAppearance()
        
        // bacground
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(red: 0.4, green: 0.4, blue: 0.5, alpha: 0.8)
                
        //title
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue]
        
        // all button
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(rightBarButtonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        navBarAppearance.buttonAppearance = barButtonItemAppearance
        navBarAppearance.backButtonAppearance = barButtonItemAppearance
        navBarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        self.navigationItem.standardAppearance = navBarAppearance
        self.navigationItem.compactAppearance = navBarAppearance
        self.navigationItem.scrollEdgeAppearance = navBarAppearance
        self.navigationItem.compactScrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func rightBarButtonAction() {
        for index in 0...self.rowCount - 1 {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! AddQuestionTableViewCell
            guard let answerA = cell.answerA.text,
                  let answerB = cell.answerB.text,
                  let answerC = cell.answerC.text,
                  let answerD = cell.answerD.text,
                  let difficultValue = cell.difficultValueLable.text else {return}
            
            builder.setQuestionText(cell.questionTextView.text)
            builder.setAnswers(answerA, for: .a)
            builder.setAnswers(answerB, for: .b)
            builder.setAnswers(answerC, for: .c)
            builder.setAnswers(answerD, for: .d)
            
            builder.setCurrentAnswer(cell.segmentedControl.selectedSegmentIndex)
            builder.setDifficult(Int(difficultValue) ?? 1)
            DataManager.data.questions.append(builder.build())
        }
        caretaker.saveQuestions(results: DataManager.data.questions)
        self.navigationController?.popViewController(animated: true)
    }
}
