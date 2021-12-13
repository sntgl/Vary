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
    
    private var wordCircleButton = UIButton()
    private var wordCicleButtonHeight = CGFloat(200)
    
    var timer: Timer?
    var countdownTime: Int?
    
    // End Views
    
    // Utils vars
    
    var gameInfo: GameInfo?
    var currentWordIndex: Int = 0
    var scoreForWord: Int = 10
    var currentRoundType: RoundType?
    var initialCircleCoord: CGFloat?
    // End util vars
    
    // Inits
    
    init(output: GameScreenViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
        self.gameInfo = getGameInfo()
        self.countdownTime = gameInfo?.gameSettings.roundTime
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // End inits
    
    
    // LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        guard let navController = self.navigationController as? CustomNavigationController else {
                  print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
                  return
              }
    
        
        self.gameInfo!.currentRoundTeams = self.gameInfo!.formTeamList()
        
        navController.myTitle = self.gameInfo?.currentRoundTeams[self.gameInfo?.currentTeam ?? 0].name
        currentRoundType = roundDesciptionView.roundType
    }
    

    
	override func viewDidLoad() {
		super.viewDidLoad()
        setupStyle()
        setupSubviews()

	}
    
    
    // End Lifecycle
    
    
    
    
    
    
    
    
    
    // Additional functions

    
    
    // Style
    
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
        
        setupWordCircleStyle()

        
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
        timerButton.isUserInteractionEnabled = false
        guard let time = self.countdownTime else{
            return
        }
        timerButton.setTitle(String(time), for: .normal)
    }
    
    
    func setupWordCircleStyle(){
        wordCircleButton = UIButton(type: .custom)
        wordCircleButton.frame = CGRect(x: 160, y: 100, width: wordCicleButtonHeight, height: wordCicleButtonHeight)
        wordCircleButton.layer.cornerRadius = 0.5 * wordCircleButton.bounds.size.width
        wordCircleButton.clipsToBounds = true
        wordCircleButton.backgroundColor = VaryColors.secondaryColor
        wordCircleButton.isHidden = true
        wordCircleButton.tintColor = VaryColors.textColor
        
        let currentCardWord: String = self.gameInfo?.cardsForGame.cards[self.currentWordIndex].name ?? "Not found"
        wordCircleButton.setTitle(currentCardWord, for: .normal)
        self.currentWordIndex += 1
        
    }
    
    
    
    // End Style setup
    
    
    
    
    
    
    
    
    // SubViews Setup
    
    func setupSubViewsInfo(){
        guard let gameInfo = gameInfo else {
            return
        }
        roundDesciptionView = RoundDescriptionView(roundType: gameInfo.currentRoundType)
        roundDesciptionView.delegate = self
        
        roundSubDescriptionLabel.text = gameInfo.currentRoundType.getRoundSubDesciption()
        roundScoreLabel.text = "0"
        guessedLabel.text = "ОТГАДАНО"
        wordsMissedLabel.text = "ПРОПУЩЕНО"
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeUp.direction = .up
        wordCircleButton.addGestureRecognizer(swipeUp)

        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeDown.direction = .down
        wordCircleButton.addGestureRecognizer(swipeDown)
    }
    
    func setupSubviews() {
        
        setupSubViewsInfo()
        
        let allElements = [

//            timerLabel,
            guessedLabel,
            
            roundDesciptionView,
            
            wordCircleButton,
            
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
    
    
    
    // Constraints
    
    func setupConstraints() {


        NSLayoutConstraint.activate([
            
            guessedLabel.topAnchor.constraint(equalTo: timerButton.bottomAnchor, constant: 10),
            guessedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            guessedLabel.heightAnchor.constraint(equalToConstant: 20),
            
//            roundDesciptionView.topAnchor.constraint(equalTo: guessedLabel.bottomAnchor, constant: 25),
            roundDesciptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundDesciptionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            roundDesciptionView.heightAnchor.constraint(equalToConstant: 150),
            roundDesciptionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            wordCircleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordCircleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            wordCircleButton.heightAnchor.constraint(equalToConstant: wordCicleButtonHeight),
            wordCircleButton.widthAnchor.constraint(equalToConstant: wordCicleButtonHeight),
            
            
            wordsMissedLabel.topAnchor.constraint(equalTo: roundInfoButton.topAnchor, constant: -30),
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
        
        self.initialCircleCoord = self.wordCircleButton.center.y
        
    }
    
    
    // End Constraints
    
    // End SubViews setup
        
    
    
    
    // Utils functions

    
    @objc func swipeHandler(gester: UISwipeGestureRecognizer) {
        guard let initialCircleCoord = self.initialCircleCoord else {
            return
        }
        let moveCoord = initialCircleCoord - self.guessedLabel.center.y - self.wordCicleButtonHeight/2 + 15
//        let downCoord = self.wordsMissedLabel.center.y - self.wordCicleButtonHeight/2 - 15

        switch gester.direction {
        case .up:
            print("Up swipe was recognized")
            UIView.animate(withDuration: 0.5) {
                self.wordCircleButton.center.y += moveCoord
            } completion: { rez in
                self.wordCircleButton.center.y = initialCircleCoord
                self.updateScore(wordGuessed: true)
            }

        case .down:
            print("Down swipe was recognpaized")
            UIView.animate(withDuration: 0.5) {
                self.wordCircleButton.center.y -= moveCoord
            } completion: { rez in
                self.wordCircleButton.center.y = initialCircleCoord
                self.updateScore(wordGuessed: false)
            }
        default:
            break
        }
        
        showNextCard()
    }

    func showNextCard(){
        
        if self.currentWordIndex >= self.gameInfo!.cardsForGame.cards.count {
            goToScoreView()
        } else{
            guard let wordCard = self.gameInfo?.getNextCard(byIndex: self.currentWordIndex) else {
                return
            }
            wordCircleButton.setTitle(wordCard.name, for: .normal)
            self.currentWordIndex += 1
        }


    }
    

    func getGameInfo() -> GameInfo?{
        // Проинициализировать UserDefaultManager - там у нас ссылка на userDefault
        let myUserDefault = UserDefaultsManager().userDefaults
        //  Вытащить из UserDefault объект по ключу и типу нужной нам структуры
        return try? myUserDefault.get(objectType: GameInfo.self, forKey: UserDefaultKeys.gameInfo)
    }

    
    @objc func updateCounter() {
        //example functionality
        
//        guard var time = self.countdownTime, let timer = self.timer else{
//            return
//        }
        if self.countdownTime! > 0 {
            self.countdownTime! -= 1
            timerButton.setTitle(String(self.countdownTime!), for: .normal)
            
        }
        else{
            self.timer!.invalidate()
            goToScoreView()
        }
    }
    
    
    
    func updateScore(wordGuessed:Bool){

        if wordGuessed{
            gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score += self.scoreForWord
            gameInfo!.guessedCardsIndex.append(self.currentWordIndex)
        }else{
            gameInfo!.notGuessedCardsIndex.append(self.currentWordIndex)
            switch gameInfo!.gameSettings.penaltyForPass {
            case .No:
                return
            case .LosePoints:
                gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score -= self.scoreForWord
            case .TaskFromPlayers:
                self.showTaskFromPlayers()
            }
            
        }
        updateScoreLabel()
    }
    
    
    func updateScoreLabel(){
        guard let gameInfo = gameInfo else {
            return
        }
        roundScoreLabel.text = String(gameInfo.currentRoundTeams[gameInfo.currentTeam].score)
    }
    
    func showTaskFromPlayers(){
        self.timer?.invalidate()
        roundDesciptionView.changeRoundType(toType: .taskFromPlayers)
        wordCircleButton.isHidden = true
        roundDesciptionView.isHidden = false

    }
    
    func goToScoreView(){
        self.output.goToScrollView()
    }
    
    
}


extension GameScreenViewController: RoundDescriptionViewDelegagate{
    func viewTouched() {

            roundDesciptionView.isHidden = true
            wordCircleButton.isHidden = false

            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    



        
    }
    
    
}

extension GameScreenViewController: GameScreenViewInput {
}
