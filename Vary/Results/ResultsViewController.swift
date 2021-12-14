//
//  ResultsViewController.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import UIKit

final class ResultsViewController: UIViewController {
    private let output: ResultsViewOutput

    private let resultTableView = UITableView()

    private let container = UIView()
    
    var gameInfo: GameInfo?
    
    private var teamList: [Team]?

    init(output: ResultsViewOutput, gameInfo: GameInfo) {
        self.output = output
        self.gameInfo = gameInfo
        
        super.init(nibName: nil, bundle: nil)
        self.teamList = self.sortList(listToSort: gameInfo.currentRoundTeams)


    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sortList(listToSort: [Team]) -> [Team] { // should probably be called sort and not filter
         // sort the fruit by name
        return listToSort.sorted() { $0.score > $1.score }
//        fruitList.reloadData(); // notify the table view the data has changed
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navController = self.navigationController as? CustomNavigationController else {
                  print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
                  return
              }
        navController.myTitle = "Набранные баллы"
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primaryColor

        resultTableView.register(ResultTableViewCell.self, forCellReuseIdentifier: "ResultCell")
        resultTableView.delegate = self
        resultTableView.dataSource = self


        resultTableView.alwaysBounceVertical             = false;
        resultTableView.backgroundColor = Colors.surfaceColor
        resultTableView.tintColor = Colors.surfaceColor


        container.backgroundColor = Colors.surfaceColor

        view.addSubview(container)
        container.addSubview(resultTableView)
        container.backgroundColor = Colors.surfaceColor

        setupConstraints()
//        scoresTableView.separatorColor = .black
//        scoresTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        scoresTableView.separatorStyle = .singleLine
    }

    func setupConstraints(){

        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)


        ].forEach({constraint in constraint.isActive = true})

        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        [
            resultTableView.topAnchor.constraint(equalTo:  container.topAnchor, constant: 20),
            resultTableView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            resultTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        ].forEach({constraint in constraint.isActive = true})
    }
}

extension ResultsViewController: ResultsViewInput {
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamList!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
        cell.teamLabel.text = self.teamList![indexPath.row].name
        cell.scoreLabel.text = String(self.teamList![indexPath.row].score)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

private extension ResultsViewController {
    enum Colors {
        static let primaryColor = UIColor(named: "Primary")!
        static let surfaceColor = UIColor(named: "Surface")!
    }
}

