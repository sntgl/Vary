//
//  GameScreenViewController.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class GameScreenViewController: UIViewController {
	private let output: GameScreenViewOutput

    // Views
    
    private let timerLabel = UILabel()
    private let guessedLabel = UILabel()
    private let wordsMissedLabel = UILabel()
    private let roundScoreLabel = UILabel()
    private let roundSubDescriptionLabel = UILabel()
    
    private let roundDesciptionView: RoundDescriptionView = RoundDescriptionView()
    // End Views
    
    var gameInfo: GameInfo?
    
    
    init(output: GameScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        self.gameInfo = getGameInfo()

    }
    
    
    func getGameInfo() -> GameInfo?{
        // Проинициализировать UserDefaultManager - там у нас ссылка на userDefault
        let myUserDefault = UserDefaultsManager().userDefaults
        //  Вытащить из UserDefault объект по ключу и типу нужной нам структуры
        return try? myUserDefault.get(objectType: GameInfo.self, forKey: UserDefaultKeys.gameInfo)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let navController = self.navigationController as? CustomNavigationController else {
                  print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
                  return
              }
        guard let gameInfo = gameInfo else {
            return
        }
        navController.myTitle = gameInfo.teamList.teamsList[game]
    }
    

    
    
    func createNewDropDown() -> DropDownMenu{
        // Проинициализировать UserDefaultManager - там у нас ссылка на userDefault
        let myUserDefault = UserDefaultsManager().userDefaults
        //  Вытащить из UserDefault объект по ключу и типу нужной нам структуры
        guard let allTeams =  try? myUserDefault.get(objectType: AllTeams.self, forKey: "allTeamsKey") else{
            return DropDownMenu(menuContent: ["Случайная"])
        }
        // Получим опционал, но из опционала ты знаешь как вытаскивать
        
        var allTeamsNames: [String] = []
        
        for team in allTeams.teamsList{
            allTeamsNames.append(team.name)
        }
        
        return DropDownMenu(menuContent: allTeamsNames)
    }
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
//        setupSubviews()
//        setupStyle()
	}
}

extension GameScreenViewController: GameScreenViewInput {
}
