//
//  ResultsTableViewCell.swift
//  WWTBM
//
//  Created by Илья Рехтин on 13.08.2022.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    static let reuseID = "results"
    
    private var date: UILabel = {
        var lable = UILabel()
        lable.textColor = .black
        lable.font = UIFont(name: "Times New Roman", size: 17)
        return lable
    }()
    
    private var percentOfCurrentAnswers: UILabel = {
        var lable = UILabel()
        lable.textAlignment = .right
        lable.textColor = .black
        lable.font = UIFont(name: "Times New Roman", size: 17)
        return lable
    }()

    func configurateCell(for gameSession: GameSession) {
        makeConstreints()
        self.date.text = gameSession.getGameDate()
        let per = (gameSession.getcurrentAnswersCount() * 100) / 10
        self.percentOfCurrentAnswers.text = "\(per) %"
    }
}

//MARK: - snapkit
private extension ResultsTableViewCell {
    func makeConstreints() {
        self.addSubview(self.date)
        date.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(3)
            make.width.equalTo(300)
        }
        
        self.addSubview(self.percentOfCurrentAnswers)
        percentOfCurrentAnswers.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(3)
            make.width.equalTo(150)
        }
    }
}
