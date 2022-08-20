//
//  ResultsViewController.swift
//  WWTBM
//
//  Created by Илья Рехтин on 13.08.2022.
//

import UIKit

class ResultsViewController: UIViewController {

    private var tableView: UITableView!
    private var service = GameCaretaker()
    private var gameResults = [GameSession]()
    
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
    
    override func loadView() {
        super.loadView()
        self.gameResults = service.fetchSaveGameSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateTableView()
        navigationBarSetup()
        makeConstraints()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    private func configurateTableView() {
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.reuseID)
        self.tableView.backgroundColor = .clear
    }
}

//MARK: - tableview datasource
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.gameResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.reuseID, for: indexPath) as! ResultsTableViewCell
        cell.configurateCell(for: self.gameResults[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
}

//MARK: - Navigation appearance
private extension ResultsViewController {
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
        
        navBarAppearance.buttonAppearance = barButtonItemAppearance
        navBarAppearance.backButtonAppearance = barButtonItemAppearance
        navBarAppearance.doneButtonAppearance = barButtonItemAppearance
        
        self.navigationItem.standardAppearance = navBarAppearance
        self.navigationItem.compactAppearance = navBarAppearance
        self.navigationItem.scrollEdgeAppearance = navBarAppearance
        self.navigationItem.compactScrollEdgeAppearance = navBarAppearance
    }
    
    @objc private func rightBarButtonAction() {
        
    }
}

//MARK: - snapKit
private extension ResultsViewController {
    func makeConstraints() {
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        self.backgroundImage.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.right.left.bottom.equalToSuperview()
        }
        self.view.addSubview(self.tableView)
       
    }
}
