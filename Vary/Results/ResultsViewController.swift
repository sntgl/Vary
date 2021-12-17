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
    
    private let nextButton = UIButton()
    private var buttonConf = UIButton.Configuration.filled()
    
    var gameInfo: GameInfo?
    
    private var teamList: [Team]?

    init(output: ResultsViewOutput, gameInfo: GameInfo) {
        self.output = output
        self.gameInfo = gameInfo
        
        super.init(nibName: nil, bundle: nil)
        self.teamList = self.sortList(listToSort: self.gameInfo!.currentRoundTeams)

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
//
//        var navigationArray = navController.viewControllers // To get all UIViewController stack as Array
//        let temp = navigationArray.last
//        navigationArray.removeAll()
//        navigationArray.append(temp!) //To remove all previous UIViewController except the last one
//        self.navigationController?.viewControllers = navigationArray
//
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        navController.myTitle = "Набранные баллы"
//        var navigationArray = navController.viewControllers // To get all UIViewController stack as Array
////        let temp = navigationArray[navigationArray.count - 2]
//        navigationArray.removeAll()
////        navigationArray.append(temp) //To remove all previous UIViewController except the last one
//        self.navigationController?.viewControllers = navigationArray
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("Appeared")
        
        
        if checkLastRound() {
            self.showCongratMessage(message:self.teamList![0].name)
        }
        
    }
    
    func showCongratMessage(message: String) {
        let alert = UIAlertController(title: "Congratulations!", message: message + " win!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.output.goToStartView()
        }))
        self.present(alert, animated: true, completion: nil)
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
        

        resultTableView.separatorColor = VaryColors.secondaryColor
        resultTableView.separatorInset = .zero
        resultTableView.separatorStyle = .singleLine
        resultTableView.tableHeaderView = UIView()

        container.backgroundColor = Colors.surfaceColor

        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = VaryColors.primaryColor
        
        nextButton.configuration = buttonConf
        nextButton.setTitle("Следующий раунд", for: .normal)
        nextButton.isEnabled = true
        nextButton.layer.cornerRadius = 0
        nextButton.backgroundColor = VaryColors.primaryColor
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 10
        nextButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nextButton.titleLabel?.textColor = VaryColors.textColor
        nextButton.titleLabel?.font =  nextButton.titleLabel?.font.withSize(25)
        nextButton.addTarget(self, action: #selector(onNextButtonClicked), for: .touchUpInside)
        
        
        view.addSubview(container)
        container.addSubview(resultTableView)
        container.addSubview(nextButton)
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
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        [
            resultTableView.topAnchor.constraint(equalTo:  container.topAnchor, constant: 20),
            resultTableView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            resultTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
        ].forEach({constraint in constraint.isActive = true})
    }
    
    @IBAction func onNextButtonClicked() {
        self.prepareGameInfoForNextRound()
        self.output.goToGameView()
    }
    
    func prepareGameInfoForNextRound(){
        deleteGuessedCards()
        cleanCurrentsVars()
        decideNextRound()
    }
    
    func deleteGuessedCards(){
        for index in self.gameInfo!.guessedCardsIndex.reversed() {
//            if let searched_index = self.gameInfo?.guessedCardsIndex.firstIndex(of: index) {
                self.gameInfo?.currentCards.remove(at: index)
//            }
            
//            self.gameInfo!.currentCards.remove(at: index)
        }
        print("Card left: \(self.gameInfo?.currentCards.first?.name)")
    }
    
    
    func cleanCurrentsVars(){
        self.gameInfo!.guessedCardsIndex = []
        self.gameInfo!.notGuessedCardsIndex = []
        self.gameInfo!.scoreOfLastRound = 0
    }
    
    
    func decideNextRound(){
        if self.gameInfo!.currentCards.count != 0 {
            self.gameInfo!.currentTeam = self.gameInfo!.getNextTeamId()
        }else{
            changeRoundType()
            self.gameInfo!.currentTeam = self.gameInfo!.getNextTeamId()
        }
    }
    
    func checkLastRound() -> Bool{
        if self.gameInfo!.getNextRoundType()  == nil {
            return true
        }else{
            return false
        }
    }
    
    func changeRoundType(){
        guard let nextRoundType = self.gameInfo!.getNextRoundType() else{
            self.output.goToStartView()
            return
        }
        self.gameInfo!.currentRoundType = nextRoundType
        self.gameInfo!.currentCards = self.gameInfo!.cardsForGame.cards
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
        cell.teamLabel.font = cell.teamLabel.font.withSize(20)
        cell.scoreLabel.font = cell.scoreLabel.font.withSize(20)
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

