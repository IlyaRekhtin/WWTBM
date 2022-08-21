//
//  AddQuestionsViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 21.08.2022.
//

import UIKit

final class AddQuestionsViewController: UIViewController {
    
    private let tableView: UITableView = {
        var tableView = UITableView()
        tableView.register(AddQuestionTableViewCell.self, forCellReuseIdentifier: AddQuestionTableViewCell.reuseID)
//        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var numberOfRow = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

//MARK: - tableview delegate, datasource
extension AddQuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.numberOfRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: AddQuestionTableViewCell.reuseID, for: indexPath) as! AddQuestionTableViewCell
        cell.backgroundColor = .clear
        return cell
    }
}

//MARK: - snap kit
private extension AddQuestionsViewController {
    func makeConstraints() {
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
