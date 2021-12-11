//
//  SettingsViewController.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//  
//

import UIKit


final class SettingsViewController: UIViewController {
	private let output: SettingsViewOutput
    
    //
    public var gameSettingsOptions: GameSettings?
    
    // Colors
    private let primaryColor = VaryColors.primaryColor
    private let surfaceColor = VaryColors.surfaceColor
    private let secondaryColor = VaryColors.secondaryColor
    private let additionalColor = VaryColors.additionalColor
    private let textColor = VaryColors.textColor

    
    // SubViews
    private let container = UIView()
    
    private let cardNumberLabel = UILabel()
    private let cardNumberShowedLabel = UILabel()
    private let cardNumberSlider = UISlider()
    
    private let roundTimeLabel = UILabel()
    private let roundTimeShowedLabel = UILabel()
    private let roundTimeSlider = UISlider()
    
    private let penaltyLabel = UILabel()
    
    private let radioGroupPenalty = RadioGroupView(titles: ["Нет", "Потеря баллов", "Задание от игроков"], defaultChecked: 0)
    
    private let commonLastWordLabel = UILabel()
    private let commonLastWordSwitcher = UISwitch()
    
    private let beginningTeamLabel = UILabel()
    private let beginningTeamPullDown = UILabel()
    
    private let chooseDeckLabel = UILabel()
    private let chooseDeckPullDown = UILabel()
    
    private let nextButton = UIButton()
    private var buttonConf = UIButton.Configuration.filled()
    
    private var labelArray: [UILabel] = []
    private var allElements: [UIView] = []
    
    private var dropDownTeam = DropDownMenu(menuContent: ["Случайная", "Команда 1", "Команда 2"])
    private let dropDownDeck = DropDownMenu(menuContent: ["Средние", "Маленькие", "Большие"])
    
    private let numberOfCartsView: SliderView = {
        let view = SliderView(titleLabelString: "Количество карт", valueLabelString: "штук")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let roundTimeView: SliderView = {
       let view = SliderView(titleLabelString: "Время раунда", valueLabelString: "сек")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var teamsInfo: AllTeams?
    // END SubViews
    
    
    init(output: SettingsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
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
        navController.myTitle = "Настройки игры"
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        setupSubviews()
        setupStyle()

	}
    
    

    
    func setupStyle() {
        
        view.backgroundColor = primaryColor
        container.backgroundColor = surfaceColor

        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = primaryColor

        commonLastWordSwitcher.isOn = true
        commonLastWordSwitcher.onTintColor = additionalColor
        commonLastWordSwitcher.thumbTintColor = secondaryColor
        
        nextButton.configuration = buttonConf
        nextButton.setTitle("Далее", for: .normal)
        nextButton.isEnabled = true
        nextButton.layer.cornerRadius = 0
        nextButton.backgroundColor = primaryColor
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 10
        nextButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        nextButton.titleLabel?.textColor = textColor
        nextButton.titleLabel?.font =  nextButton.titleLabel?.font.withSize(25)
        nextButton.addTarget(self, action: #selector(onNextButtonClicked), for: .touchUpInside)
        
        labelArray = [
                      penaltyLabel, commonLastWordLabel,
                      beginningTeamLabel, chooseDeckLabel
        ]

        penaltyLabel.text = "Штраф за пропуск"
        commonLastWordLabel.text = "Общее последнее слово"
        beginningTeamLabel.text = "Начинающая команда"
        chooseDeckLabel.text = "Выбрать колоду"
        
        beginningTeamPullDown.text = "Вместо выпадающего списка"
        chooseDeckPullDown.text = "Вместо выпадающего списка"
        
        for label in labelArray{
            label.font = label.font.withSize(20)
            label.textColor = primaryColor
        }
        
    }
    
    
    func createNewDropDown() -> DropDownMenu{
        // Проинициализировать UserDefaultManager - там у нас ссылка на userDefault
        let myUserDefault = UserDefaultsManager().userDefaults
        //  Вытащить из UserDefault объект по ключу и типу нужной нам структуры
        guard let allTeams =  try? myUserDefault.get(objectType: AllTeams.self, forKey: "allTeamsKey") else{
            return DropDownMenu(menuContent: ["Случайная"])
        }
        // Получим опционал, но из опционала ты знаешь как вытаскивать
        
        self.teamsInfo = allTeams
        
        var allTeamsNames: [String] = []
        
        for team in allTeams.teamsList{
            allTeamsNames.append(team.name)
        }
        
        return DropDownMenu(menuContent: allTeamsNames)
    }
    
    func setupSubviews() {
        dropDownTeam = createNewDropDown()
        
        allElements = [

            numberOfCartsView,
            roundTimeView,
            radioGroupPenalty,
            penaltyLabel,
            commonLastWordLabel,
            commonLastWordSwitcher,
            beginningTeamLabel,
            chooseDeckLabel,
            dropDownTeam,
            dropDownDeck,
            nextButton
        ]

        view.addSubview(container)
        
        allElements.forEach({v in container.addSubview(v)})
        allElements.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})
        setupConstraints()
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
            
        ].forEach({constraint in constraint.isActive = true})


        NSLayoutConstraint.activate([
            
            numberOfCartsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            numberOfCartsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberOfCartsView.widthAnchor.constraint(equalToConstant: 300),
            
            roundTimeView.topAnchor.constraint(equalTo: numberOfCartsView.bottomAnchor, constant: numberOfCartsView.frame.height + 12),
            roundTimeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roundTimeView.widthAnchor.constraint(equalToConstant: 300),
            
            penaltyLabel.topAnchor.constraint(equalTo: roundTimeView.bottomAnchor, constant: 24),
            penaltyLabel.leadingAnchor.constraint(equalTo: roundTimeView.leadingAnchor),
            
            radioGroupPenalty.topAnchor.constraint(equalTo: penaltyLabel.bottomAnchor, constant: 12),
            radioGroupPenalty.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            radioGroupPenalty.heightAnchor.constraint(equalToConstant: 120),
            
            commonLastWordLabel.topAnchor.constraint(equalTo: radioGroupPenalty.bottomAnchor, constant: 24),
            commonLastWordLabel.leadingAnchor.constraint(equalTo: penaltyLabel.leadingAnchor),
            
            commonLastWordSwitcher.topAnchor.constraint(equalTo: commonLastWordLabel.topAnchor),
            commonLastWordSwitcher.leadingAnchor.constraint(equalTo: commonLastWordLabel.trailingAnchor, constant: 8),

            beginningTeamLabel.topAnchor.constraint(equalTo: commonLastWordLabel.bottomAnchor, constant: 24),
            beginningTeamLabel.leadingAnchor.constraint(equalTo: commonLastWordLabel.leadingAnchor),
            
            dropDownTeam.topAnchor.constraint(equalTo: beginningTeamLabel.bottomAnchor, constant: 12),
            dropDownTeam.leadingAnchor.constraint(equalTo: beginningTeamLabel.leadingAnchor),
            dropDownTeam.trailingAnchor.constraint(equalTo: commonLastWordSwitcher.trailingAnchor),

            chooseDeckLabel.topAnchor.constraint(equalTo: dropDownTeam.bottomAnchor, constant: 24),
            chooseDeckLabel.leadingAnchor.constraint(equalTo: beginningTeamLabel.leadingAnchor),
            
            dropDownDeck.topAnchor.constraint(equalTo: chooseDeckLabel.bottomAnchor, constant: 12),
            dropDownDeck.leadingAnchor.constraint(equalTo: dropDownTeam.leadingAnchor),
            dropDownDeck.trailingAnchor.constraint(equalTo: dropDownTeam.trailingAnchor),
    
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
        ])
    }
    
    func collectGameSettings(){
        self.gameSettingsOptions = GameSettings(cardNumber: numberOfCartsView.valueIntString ?? 60,
                                                 roundTime: roundTimeView.valueIntString ?? 60,
                                                 penaltyForPass: radioGroupPenalty.currentChecked ?? 0,
                                                 lastCommonWord: commonLastWordSwitcher.isOn,
                                                 beginningTeam: dropDownTeam.selectedRow,
                                                 chosenDeck: dropDownTeam.selectedRowTitle ?? "Средние")
    }
    
    
    @IBAction func onNextButtonClicked() {
        self.collectGameSettings()
        output.onNextButtonClicked()
    }
}

extension SettingsViewController: SettingsViewInput {
}
    

//
//extension UINavigationBar {
//
//
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        let navigationNormalHeight: CGFloat = 44
//        let navigationExtendHeight: CGFloat = 84
//
//        var barHeight: CGFloat = navigationNormalHeight
//
//        if size.height == navigationExtendHeight {
//            barHeight = size.height
//        }
//
//        let newSize: CGSize = CGSize(width: self.frame.size.width, height: barHeight)
//        return newSize
//    }
//}
