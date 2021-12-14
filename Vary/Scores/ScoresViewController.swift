//
//  ScoresViewController.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import UIKit

final class ScoresViewController: UIViewController {
	private let output: ScoresViewOutput

    private let scoresTableView = UITableView()

    private let container = UIView()
    
    private let nextButton = UIButton()
    private var buttonConf = UIButton.Configuration.filled()
    private let tipLable = UILabel()
    
//    var gameInfo = ["аббревиатура", "абитуриент", "абонемент", "аборт", "абракадабра", "абсент", "авария", "авгур", "автокефалия", "агальма", "агломерат", "аграф", "адепт", "адмирал", "ажиотаж", "азарт", "акант", "аквилон", "аккламация", "акколада", "аккордеон", "акрибия", "акробатика", "акростих", "аксиология", "акупунктура", "акут", "акушер", "алеаторика", "алембик", "алиби", "алкоголь", "аллергия"]
    var gameInfo: GameInfo?
    
//    var guessedCardsIndex = [2,3,4,10]
    
    
    init(output: ScoresViewOutput, gameInfo: GameInfo) {
        self.output = output
        self.gameInfo = gameInfo
        super.init(nibName: nil, bundle: nil)
//        title = "Набранные баллы"


    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor        = VaryColors.primaryColor
        
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = VaryColors.primaryColor
        
        nextButton.configuration = buttonConf
        nextButton.setTitle("Готово", for: .normal)
        nextButton.isEnabled = true
        nextButton.layer.cornerRadius = 0
        nextButton.backgroundColor = VaryColors.primaryColor
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 10
        nextButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nextButton.titleLabel?.textColor = VaryColors.textColor
        nextButton.titleLabel?.font =  nextButton.titleLabel?.font.withSize(25)
        nextButton.addTarget(self, action: #selector(onNextButtonClicked), for: .touchUpInside)
        
        tipLable.textColor = VaryColors.textColor
        tipLable.text =  "Нажмите на слово, чтобы изменить его результат"
        tipLable.numberOfLines = 1
        tipLable.font = tipLable.font.withSize(12)
        tipLable.textAlignment = .center;
        
        scoresTableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: "Cell")
        scoresTableView.delegate = self
        scoresTableView.dataSource = self


        scoresTableView.alwaysBounceVertical             = false;
        scoresTableView.backgroundColor = VaryColors.surfaceColor
        scoresTableView.tintColor = VaryColors.surfaceColor
        scoresTableView.allowsMultipleSelection = true
        

        view.addSubview(container)
        container.addSubview(scoresTableView)
        container.addSubview(nextButton)
        container.addSubview(tipLable)
        
        container.backgroundColor = VaryColors.surfaceColor

        setupConstraints()
       
        
//        setupNavController(navTitle: "SCores")
    
	}
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        guard let navController = self.navigationController as? CustomNavigationController else {
                  print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
                  return
              }
        navController.myTitle = "Набранные баллы"
       
//        selectGuessedWords()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }

    func setupConstraints(){

        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)


        ].forEach({constraint in constraint.isActive = true})

        scoresTableView.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        tipLable.translatesAutoresizingMaskIntoConstraints = false
        
        [
            scoresTableView.topAnchor.constraint(equalTo:  container.topAnchor, constant: 20),
            scoresTableView.bottomAnchor.constraint(equalTo: tipLable.topAnchor, constant: -10),
            scoresTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoresTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            tipLable.topAnchor.constraint(equalTo: scoresTableView.bottomAnchor),
            tipLable.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -10),
            tipLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tipLable.widthAnchor.constraint(equalTo: nextButton.widthAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            
        ].forEach({constraint in constraint.isActive = true})
    }
    
    
    @IBAction func onNextButtonClicked() {
        self.reCalculateScore()
        self.output.goToResultsView()
    }
    
    
    func reCalculateScore(){
        let scoreForWord: Int = 10
        let scoreForGuessed =  self.gameInfo!.guessedCardsIndex.count * scoreForWord
        var scoreForNotGuessed = 0
        switch gameInfo!.gameSettings.penaltyForPass {
        case .No:
            break
        case .LosePoints:
            scoreForNotGuessed =  self.gameInfo!.notGuessedCardsIndex.count * scoreForWord * (-1)
//                gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score -= self.scoreForWord
        case .TaskFromPlayers:
            break
        }
        self.gameInfo!.scoreOfLastRound = scoreForGuessed + scoreForNotGuessed
        self.gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score += self.gameInfo!.scoreOfLastRound
    
    }
//        if dawd {
//            gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score += self.scoreForWord
//            gameInfo!.guessedCardsIndex.append(self.currentWordIndex)
//        }else{
//            gameInfo!.notGuessedCardsIndex.append(self.currentWordIndex)
//            switch gameInfo!.gameSettings.penaltyForPass {
//            case .No:
//                return
//            case .LosePoints:
//                gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score -= self.scoreForWord
//            case .TaskFromPlayers:
//                self.showTaskFromPlayers()
//            }
//
//        }
//
//    }
    
}

extension ScoresViewController: ScoresViewInput {
}

extension ScoresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gameInfo!.cardsForGame.cards.count
//        return self.gameInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScoreTableViewCell
       
//        self.tableView.separatorStyle = UITableViewSeparatorStyleNone;

//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none
        
//        cell.wordLabel.text = self.gameInfo!.cardsForGame.cards[indexPath.row].name
        print("Created Cell ")
        print("Row = \(indexPath.row) and Section = \(indexPath.section)")
        cell.wordLabel.text = self.gameInfo?.cardsForGame.cards[indexPath.row].name
        if self.gameInfo!.guessedCardsIndex.contains(indexPath.row){
            print("YESSS \(self.gameInfo?.guessedCardsIndex) contains: \(indexPath.row)")
            print("--------------------------------")
            cell.wordLabel.textColor = VaryColors.primaryColor
//            cell.setSelected(true, animated: false)
//            cell.isSelected = true
        }else{
            cell.wordLabel.textColor = VaryColors.textColor
        }

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScoreTableViewCell
//        cell.tintColor = VaryColors.secondaryColor
        print("Selected Cell ")
        print("Row = \(indexPath.row) and Section = \(indexPath.section)")
//
//        print(String(indexPath.section))
        let cell = scoresTableView.cellForRow(at: indexPath) as! ScoreTableViewCell
        if cell.wordLabel.textColor == VaryColors.primaryColor{
            print("Cell was Selected")
            cell.wordLabel.textColor = VaryColors.textColor
            if let index = self.gameInfo?.guessedCardsIndex.firstIndex(of: indexPath.row) {
                self.gameInfo?.guessedCardsIndex.remove(at: index)
            }
            self.gameInfo?.notGuessedCardsIndex.append(indexPath.row)
            
        }else if cell.wordLabel.textColor == VaryColors.textColor {
            print("Cell was not Selected")
            cell.wordLabel.textColor = VaryColors.primaryColor
            self.gameInfo?.guessedCardsIndex.append(indexPath.row)
            if let index = self.gameInfo?.notGuessedCardsIndex.firstIndex(of: indexPath.row) {
                self.gameInfo?.notGuessedCardsIndex.remove(at: index)
            }
     
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}
}

//private extension ScoresViewController {
//
//}

