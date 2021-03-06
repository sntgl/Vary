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
    
    private let container = UIView()
    
    private var wordCircleButton = UIButton()
    private var wordCicleButtonHeight = CGFloat(200)
    
    var timer: Timer?
    var countdownTime: Int?
    
    // End Views
    
    // Utils vars
    
    var gameInfo: GameInfo?
    var currentWordIndex: Int = 0
    var scoreForWord: Int = VaryVars.scoreForWord
    var currentRoundType: RoundType?
    var initialCircleCoord: CGFloat?
    // End util vars
    
    // Inits
    
    init(output: GameScreenViewOutput, gameInfo: GameInfo) {
        self.output = output
        self.gameInfo = gameInfo
        super.init(nibName: nil, bundle: nil)

        self.countdownTime = self.gameInfo?.gameSettings.roundTime
        
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

        showNavBackButon()
        
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
        view.backgroundColor = VaryVars.Colors.primaryColor
        container.backgroundColor = VaryVars.Colors.surfaceColor
        
        
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = VaryVars.Colors.additionalColor
        
        roundInfoButton.configuration = buttonConf
        roundInfoButton.isEnabled = false
        roundInfoButton.backgroundColor = VaryVars.Colors.additionalColor
        roundInfoButton.clipsToBounds = true
        roundInfoButton.layer.cornerRadius = 10
        roundInfoButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        roundInfoButton.titleLabel?.textColor = VaryVars.Colors.textColor
        roundInfoButton.titleLabel?.font =  roundInfoButton.titleLabel?.font.withSize(25)
        
        
        guessedLabel.textColor = VaryVars.Colors.primaryColor
        guessedLabel.font = guessedLabel.font.withSize(20)
        
        
        wordsMissedLabel.textColor = VaryVars.Colors.additionalColor
        wordsMissedLabel.font = wordsMissedLabel.font.withSize(20)
        
        roundScoreLabel.textColor = VaryVars.Colors.textColor
        roundScoreLabel.font = roundScoreLabel.font.withSize(25)
        
        
        roundSubDescriptionLabel.textColor = VaryVars.Colors.textColor
        roundSubDescriptionLabel.font = roundSubDescriptionLabel.font.withSize(25)
        
        setupWordCircleStyle()

        
        setupTimerButtonStyle()
    }
    
    func setupTimerButtonStyle(){
        
        var timerButtonConf = UIButton.Configuration.filled()
        timerButtonConf.buttonSize = .large
        timerButtonConf.baseBackgroundColor = VaryVars.Colors.primaryColor

        timerButton.configuration = timerButtonConf
//        navBarLabelButton.setTitle(title, for: .normal)
        timerButton.isEnabled = true
        timerButton.layer.cornerRadius = 0
        timerButton.backgroundColor = VaryVars.Colors.primaryColor
        timerButton.clipsToBounds = true
        timerButton.layer.cornerRadius = 10
        timerButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        timerButton.titleLabel?.textColor = VaryVars.Colors.textColor
        // bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(45)
//        navBarLabelButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Light", size: 45)
//        myTitleButton = navBarLabelButton
        timerButton.isUserInteractionEnabled = false
        guard let time = self.countdownTime else{
            return
        }
        timerButton.setTitle(getTimeStringPresentation(timerCountDown: time), for: .normal)
    }
    
    
    func setupWordCircleStyle(){
        wordCircleButton = UIButton(type: .custom)
        wordCircleButton.frame = CGRect(x: 160, y: 100, width: wordCicleButtonHeight, height: wordCicleButtonHeight)
        wordCircleButton.layer.cornerRadius = 0.5 * wordCircleButton.bounds.size.width
        wordCircleButton.clipsToBounds = true
        wordCircleButton.backgroundColor = VaryVars.Colors.secondaryColor
        wordCircleButton.isHidden = true
        wordCircleButton.tintColor = VaryVars.Colors.textColor
        
        let currentCardWord: String = self.gameInfo?.currentCards[self.currentWordIndex].name ?? "Not found"
        wordCircleButton.setTitle(currentCardWord, for: .normal)
//        self.currentWordIndex += 1
        
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
        guessedLabel.text = VaryVars.Strings.Guessed.uppercased()
        wordsMissedLabel.text = VaryVars.Strings.Skipped.uppercased()
        
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

        view.addSubview(container)
        
        
        allElements.forEach({v in container.addSubview(v)})
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
        container.addSubview(timerButton)
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            timerButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            timerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ])
        
    }
    
    
    
    // Constraints
    
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
            
        ].forEach({constraint in constraint.isActive = true})

        NSLayoutConstraint.activate([
            
            guessedLabel.topAnchor.constraint(equalTo: timerButton.bottomAnchor, constant: 10),
            guessedLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            guessedLabel.heightAnchor.constraint(equalToConstant: 20),
            
//            roundDesciptionView.topAnchor.constraint(equalTo: guessedLabel.bottomAnchor, constant: 25),
            roundDesciptionView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            roundDesciptionView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            roundDesciptionView.heightAnchor.constraint(equalToConstant: 150),
            roundDesciptionView.widthAnchor.constraint(equalTo: container.widthAnchor),
            
            wordCircleButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            wordCircleButton.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            wordCircleButton.heightAnchor.constraint(equalToConstant: wordCicleButtonHeight),
            wordCircleButton.widthAnchor.constraint(equalToConstant: wordCicleButtonHeight),
            
            
            wordsMissedLabel.topAnchor.constraint(equalTo: roundInfoButton.topAnchor, constant: -30),
            wordsMissedLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
//            wordsMissedLabel.widthAnchor.constraint(equalToConstant: 300),
            wordsMissedLabel.bottomAnchor.constraint(equalTo: roundInfoButton.topAnchor),
            
//            roundInfoButton.topAnchor.constraint(equalTo: wordsMissedLabel.bottomAnchor, constant: 10),
            roundInfoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            roundInfoButton.heightAnchor.constraint(equalTo: roundSubDescriptionLabel.heightAnchor, constant: 60),
            roundInfoButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            roundInfoButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            
            roundScoreLabel.topAnchor.constraint(equalTo: roundInfoButton.topAnchor, constant: 5),
            roundScoreLabel.centerXAnchor.constraint(equalTo: roundInfoButton.centerXAnchor),
//            roundScoreLabel.widthAnchor.constraint(equalTo: roundInfoButton.widthAnchor),
            
            roundSubDescriptionLabel.topAnchor.constraint(equalTo: roundScoreLabel.bottomAnchor, constant: 5),
            roundSubDescriptionLabel.centerXAnchor.constraint(equalTo: roundInfoButton.centerXAnchor),
//            roundSubDescriptionLabel.widthAnchor.constraint(equalTo: roundInfoButton.widthAnchor),
//            roundSubDescriptionLabel.bottomAnchor.constraint(equalTo: roundInfoButton.bottomAnchor),
  
        ])
        
        self.initialCircleCoord = self.wordCircleButton.center.y
        
    }
    
    
    // End Constraints
    
    // End SubViews setup
        
    
    
    
    // Utils functions

    
    @objc func swipeHandler(gester: UISwipeGestureRecognizer) {
//        guard let initialCircleCoord = self.initialCircleCoord else {
//            return
//        }
        let initialCircleCoord = self.wordCircleButton.center.y
//        let moveCoord = initialCircleCoord - self.guessedLabel.center.y - self.wordCicleButtonHeight/2 + 15
//        let downCoord = self.wordsMissedLabel.center.y - self.wordCicleButtonHeight/2 - 15
        print("Initial coord: \(initialCircleCoord)")
        switch gester.direction {
        case .up:
            print("Up swipe was recognized")
            self.updateScore(wordGuessed: true)
            UIView.animate(withDuration: 0.5) {
//                print("Start from: \(self.wordCircleButton.center.y )")
                self.wordCircleButton.center.y -= 150
//                self.wordCircleButton.center.y = initialCircleCoord
//                print("End from: \(self.wordCircleButton.center.y )")
            } completion: { rez in
                self.wordCircleButton.center.y = initialCircleCoord
                self.showNextCard()
            }

        case .down:
            print("Down swipe was recognpaized")
            self.updateScore(wordGuessed: false)
            UIView.animate(withDuration: 0.5) {
//                print("Start from: \(self.wordCircleButton.center.y )")
                self.wordCircleButton.center.y += 150
//                self.wordCircleButton.center.y = initialCircleCoord
//                print("End from: \(self.wordCircleButton.center.y )")
            } completion: { rez in
                self.wordCircleButton.center.y = initialCircleCoord
                self.showNextCard()
            }
        default:
            break
        }
        
       
    }

    func showNextCard(){
        
        if self.currentWordIndex >= self.gameInfo!.currentCards.count - 1 {
            self.timer!.invalidate()
            goToScoreView()
        } else{
            guard let wordCard = self.gameInfo?.getNextCard(byIndex: self.currentWordIndex) else {
                return
            }
            wordCircleButton.setTitle(wordCard.name, for: .normal)
            self.currentWordIndex += 1
        }


    }
    

    
    @objc func updateCounter() {

        print("COUNTDOWN LEFT - \(self.countdownTime!)")
        if self.countdownTime! > 0 {
            self.countdownTime! -= 1
            timerButton.setTitle(getTimeStringPresentation(timerCountDown: self.countdownTime!), for: .normal)
            
        }
        else{
            self.timer!.invalidate()
            markLeftWordsAsUnGuessed()
            goToScoreView()
        }
    }
    
    func markLeftWordsAsUnGuessed(){
        for index in self.currentWordIndex..<self.gameInfo!.currentCards.count{
            self.gameInfo!.notGuessedCardsIndex.append(gameInfo!.currentCards[self.currentWordIndex].id)
        }
    }
    
    func convertDexTime(time: Int) -> String{
        if time >= 10{
            return String(time)
        }else {
            return "0\(time)"
        }
    }
    
    func getTimeStringPresentation(timerCountDown: Int) -> String{
        let minutesLeft = convertDexTime(time: timerCountDown / 60)
        let secondsLeft = convertDexTime(time: timerCountDown % 60)
        return "\(minutesLeft):\(secondsLeft)"
    }
    
    
    func updateScore(wordGuessed:Bool){

        if wordGuessed{
            gameInfo!.scoreOfLastRound  += self.scoreForWord
//            gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score += self.scoreForWord
            gameInfo!.guessedCardsIndex.append(gameInfo!.currentCards[self.currentWordIndex].id)
        }else{
            gameInfo!.notGuessedCardsIndex.append(gameInfo!.currentCards[self.currentWordIndex].id)
            switch gameInfo!.gameSettings.penaltyForPass {
            case .No:
                return
            case .LosePoints:
                gameInfo!.scoreOfLastRound  -= self.scoreForWord
//                gameInfo!.currentRoundTeams[gameInfo!.currentTeam].score -= self.scoreForWord
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
        roundScoreLabel.text = String(gameInfo.scoreOfLastRound)
    }
    
    
    func showNavBackButon(){
        if self.gameInfo!.gameStarted {
            self.navigationItem.setHidesBackButton(false, animated: true)
            self.gameInfo!.gameStarted = false
        }else{
            self.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
    

    func checkIfGameStarted() -> Bool{
        guard let info = self.gameInfo  else {
                  return true
        }
        
        if (info.currentTeam == 0) && (self.checkLastRound()) {
            return true
        }else{
            return false
        }
    }
    
    func checkLastRound() -> Bool{
        if self.gameInfo!.getNextRoundType()  == RoundType.show {
            return true
        }else{
            return false
        }
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
