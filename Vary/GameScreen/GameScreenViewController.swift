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
    
    private let roundInfoButton = UIButton()
    private var buttonConf = UIButton.Configuration.filled()
    
    private var roundDesciptionView: RoundDescriptionView = RoundDescriptionView()
    
    private var timerButton = UIButton()
    
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
        navController.myTitle = gameInfo.allTeamsInfo.teamsList[gameInfo.currentTeam].name
    }
    

    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupStyle()
        setupSubviews()

	}

    func setupStyle() {
        view.backgroundColor = VaryColors.surfaceColor
        
        
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = VaryColors.additionalColor
        
        roundInfoButton.configuration = buttonConf
        roundInfoButton.isEnabled = false
        roundInfoButton.backgroundColor = VaryColors.additionalColor
        roundInfoButton.clipsToBounds = true
        roundInfoButton.layer.cornerRadius = 10
        roundInfoButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundInfoButton.titleLabel?.textColor = VaryColors.textColor
        roundInfoButton.titleLabel?.font =  roundInfoButton.titleLabel?.font.withSize(25)
        
        
        guessedLabel.textColor = VaryColors.primaryColor
        guessedLabel.font = guessedLabel.font.withSize(20)
        
        
        wordsMissedLabel.textColor = VaryColors.additionalColor
        wordsMissedLabel.font = wordsMissedLabel.font.withSize(20)
        
        roundScoreLabel.textColor = VaryColors.textColor
        roundScoreLabel.font = roundScoreLabel.font.withSize(25)
        
        
        roundSubDescriptionLabel.textColor = VaryColors.textColor
        roundSubDescriptionLabel.font = roundSubDescriptionLabel.font.withSize(25)
        
        setupTimerButtonStyle()
    }
    
    func setupTimerButtonStyle(){
        
        var timerButtonConf = UIButton.Configuration.filled()
        timerButtonConf.buttonSize = .large
        timerButtonConf.baseBackgroundColor = VaryColors.primaryColor

        timerButton.configuration = timerButtonConf
//        navBarLabelButton.setTitle(title, for: .normal)
        timerButton.isEnabled = true
        timerButton.layer.cornerRadius = 0
        timerButton.backgroundColor = VaryColors.primaryColor
        timerButton.clipsToBounds = true
        timerButton.layer.cornerRadius = 10
        timerButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        timerButton.titleLabel?.textColor = VaryColors.textColor
        // bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(45)
//        navBarLabelButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Light", size: 45)
//        myTitleButton = navBarLabelButton
        timerButton.setTitle("01:00", for: .normal)

        
    }
    
    func setupSubTimerButton(){
        // navBar SubView
        view.addSubview(timerButton)
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timerButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            timerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ])
        
    }
    
    func setupSubviews() {
        guard let gameInfo = gameInfo else {
            return
        }
        roundDesciptionView = RoundDescriptionView(roundType: gameInfo.currentRoundType)
        roundSubDescriptionLabel.text = gameInfo.currentRoundType.getRoundSubDesciption()
        roundScoreLabel.text = "0"
        guessedLabel.text = "ОТГАДАНО"
        wordsMissedLabel.text = "ПРОПУЩЕНО"
        let allElements = [

//            timerLabel,
            guessedLabel,
            
            roundDesciptionView,
            
            wordsMissedLabel,
            
            roundInfoButton,
        ]

        
        allElements.forEach({v in view.addSubview(v)})
        allElements.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})
        
        
        let roundButtonElements = [
            
            roundScoreLabel,
            roundSubDescriptionLabel,
        ]
        
        roundButtonElements.forEach({v in roundInfoButton.addSubview(v)})
        roundButtonElements.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})
        setupSubTimerButton()
        setupConstraints()
        
    }
    
    
    func setupConstraints() {


        NSLayoutConstraint.activate([
            
            guessedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            guessedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessedLabel.heightAnchor.constraint(equalToConstant: 20),
            
//            roundDesciptionView.topAnchor.constraint(equalTo: guessedLabel.bottomAnchor, constant: 25),
            roundDesciptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundDesciptionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            roundDesciptionView.heightAnchor.constraint(equalToConstant: 150),
            roundDesciptionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            wordsMissedLabel.topAnchor.constraint(equalTo: roundInfoButton.topAnchor, constant: -20),
            wordsMissedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            wordsMissedLabel.widthAnchor.constraint(equalToConstant: 300),
            wordsMissedLabel.bottomAnchor.constraint(equalTo: roundInfoButton.topAnchor),
            
//            roundInfoButton.topAnchor.constraint(equalTo: wordsMissedLabel.bottomAnchor, constant: 10),
            roundInfoButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            roundInfoButton.heightAnchor.constraint(equalTo: roundSubDescriptionLabel.heightAnchor, constant: 30),
            roundInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundInfoButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            
            roundScoreLabel.topAnchor.constraint(equalTo: roundInfoButton.topAnchor, constant: 5),
            roundScoreLabel.centerXAnchor.constraint(equalTo: roundInfoButton.centerXAnchor),
//            roundScoreLabel.widthAnchor.constraint(equalTo: roundInfoButton.widthAnchor),
            
            roundSubDescriptionLabel.topAnchor.constraint(equalTo: roundScoreLabel.bottomAnchor, constant: 5),
            roundSubDescriptionLabel.centerXAnchor.constraint(equalTo: roundInfoButton.centerXAnchor),
//            roundSubDescriptionLabel.widthAnchor.constraint(equalTo: roundInfoButton.widthAnchor),
            roundSubDescriptionLabel.bottomAnchor.constraint(equalTo: roundInfoButton.bottomAnchor),
  
        ])
        
    }


}



extension GameScreenViewController: GameScreenViewInput {
}
