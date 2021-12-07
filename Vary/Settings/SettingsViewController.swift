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
    
    // Make file with public colors
    private let primaryColor = UIColor(named: "Primary")!
    private let surfaceColor = UIColor(named: "Surface")!
    private let secondaryColor = UIColor(named: "Secondary")!
    private let additionalColor = UIColor(named: "Additional")!
    private let textColor = UIColor(named: "TextBright")!
    
    private let container = UIView()
    
    private let bigSettingsLabelButton = UIButton()
    
    private let cardNumberLabel = UILabel()
    private let cardNumberShowedLabel = UILabel()
    private let cardNumberSlider = UISlider()
    
    private let roundTimeLabel = UILabel()
    private let roundTimeShowedLabel = UILabel()
    private let roundTimeSlider = UISlider()
    
    private let penaltyLabel = UILabel()
//    private let radioGroupPenalty = RadioGroup(titles: ["Нет", "Потеря баллов", "Задание от игроков"])
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
    
    private let dropDownTeam = DropDownMenu(menuContent: ["Случайная", "Команда 1", "Команда 2"] )
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
    
    init(output: SettingsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
 
        setupSubviews()
        setupStyle()
        setupNavController()
//
	}
    
    func setupNavController(){
        guard let navController = self.navigationController else {
            print("no nav controller")
            return
        }
        navController.setNavigationBarHidden(false, animated: true)

//        let label = UILabel()
//        title = "Настройки игры"
//        navController.navigationBar.topItem?.title = "Your title"
//        navController.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 34)!, NSAttributedString.Key.foregroundColor: UIColor.white]
        
//        navController.navigationBar.frame.size = navController.navigationBar.sizeThatFits(CGSize(width: navController.navigationBar.frame.size.width,height: 80))
        
//        navController.navigationBar.titleTextAttributes = [
//                    .foregroundColor: UIColor.white,
//                ]
//        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 45)!]
//        UINavigationBar.appearance().titleTextAttributes = attributes
//
//        let height: CGFloat = 25 //whatever height you want to add to the existing height
//        let bounds = self.navigationController!.navigationBar.bounds
        
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
//        navController.navigationItem.titleView = label
//        navController.navigationBar.addSubview(bigSettingsLabelButton)
//        bigSettingsLabelButton.translatesAutoresizingMaskIntoConstraints = false
        
        
//       buttonConf.buttonSize = .large
//       buttonConf.baseBackgroundColor = primaryColor

//       bigSettingsLabelButton.configuration = buttonConf
//       bigSettingsLabelButton.setTitle("Настройки игры", for: .normal)
//       bigSettingsLabelButton.isEnabled = true
//       bigSettingsLabelButton.layer.cornerRadius = 0
//       bigSettingsLabelButton.backgroundColor = primaryColor
//       bigSettingsLabelButton.clipsToBounds = true
//       bigSettingsLabelButton.layer.cornerRadius = 30
//       bigSettingsLabelButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//       //bigSettingsLabelButton.isUserInteractionEnabled = false
//       bigSettingsLabelButton.titleLabel?.textColor = textColor
//       bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(25)
////        UIApplication.shared.keyWindow!.bringSubviewToFront(navController.navigationBar)
//        navController.navigationBar.layer.
//        bigSettingsLabelButton.addSubview(navController)
        
//        navController.navigationBar.isTranslucent = true;
        
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = primaryColor

        bigSettingsLabelButton.configuration = buttonConf
        bigSettingsLabelButton.setTitle("Настройки игры", for: .normal)
        bigSettingsLabelButton.isEnabled = true
        bigSettingsLabelButton.layer.cornerRadius = 0
        bigSettingsLabelButton.backgroundColor = primaryColor
        bigSettingsLabelButton.clipsToBounds = true
        bigSettingsLabelButton.layer.cornerRadius = 10
        bigSettingsLabelButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        //bigSettingsLabelButton.isUserInteractionEnabled = false
        bigSettingsLabelButton.titleLabel?.textColor = textColor
//        bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(45)
        bigSettingsLabelButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Light", size: 45)
        navController.navigationBar.addSubview(bigSettingsLabelButton)
        NSLayoutConstraint.activate([
            
            
            bigSettingsLabelButton.topAnchor.constraint(equalTo: navController.navigationBar.topAnchor),
//            bigSettingsLabelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            bigSettingsLabelButton.heightAnchor.constraint(equalToConstant: 10),
            bigSettingsLabelButton.widthAnchor.constraint(equalTo: navController.navigationBar.widthAnchor),
            ])
        navController.navigationBar.sendSubviewToBack(bigSettingsLabelButton)
//        bigSettingsLabelButton.alpha = 0.2
//        let xPosition = navController.navigationBar.frame.origin.x
//        let yPosition = navController.navigationBar.frame.origin.y - 20 // Slide Up - 20px

//        let width = bigSettingsLabelButton.frame.size.width
//        let height = bigSettingsLabelButton.frame.size.height

//        bigSettingsLabelButton.frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
//        self.view.sendSubviewToBack(bigSettingsLabelButton)
        

        bigSettingsLabelButton.translatesAutoresizingMaskIntoConstraints = false
        bigSettingsLabelButton.layer.zPosition = -1;
        bigSettingsLabelButton.isUserInteractionEnabled = false

    }

    
    func setupStyle() {
        view.backgroundColor = primaryColor
        
        container.backgroundColor = surfaceColor

        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = primaryColor

//        bigSettingsLabelButton.configuration = buttonConf
//        bigSettingsLabelButton.setTitle("Настройки игры", for: .normal)
//        bigSettingsLabelButton.isEnabled = true
//        bigSettingsLabelButton.layer.cornerRadius = 0
//        bigSettingsLabelButton.backgroundColor = primaryColor
//        bigSettingsLabelButton.clipsToBounds = true
//        bigSettingsLabelButton.layer.cornerRadius = 10
//        bigSettingsLabelButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        //bigSettingsLabelButton.isUserInteractionEnabled = false
//        bigSettingsLabelButton.titleLabel?.textColor = textColor
//        bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(25)


        
        
        //radioGroupPenalty.titleColor = textColor
        //radioGroupPenalty.spacing = 25
        //radioGroupPenalty.itemSpacing = 5
        //radioGroupPenalty.tintColor = secondaryColor       // surrounding ring
        //radioGroupPenalty.selectedColor = secondaryColor     // inner circle (default is same color as ring)
        //radioGroupPenalty.selectedTintColor = secondaryColor  // selected radio button's surrounding ring (default is tintColor)
        //radioGroupPenalty.selectedIndex = 1
        
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
        
        //dropDownTeam.dataSourse = ["Команда 1", "Команда 2"]
        //dropDownDeck.dataSourse = ["Маленькие", "Большие"]
        
        for label in labelArray{
            label.font = label.font.withSize(20)
            label.textColor = primaryColor
        }
        
    }
    
    func setupSubviews() {
        allElements = [
//            bigSettingsLabelButton,

            // sliders views
            numberOfCartsView,
            roundTimeView,
            
//
            radioGroupPenalty,
//
//            commonLastWordSwitcher,
//

            penaltyLabel,
            commonLastWordLabel,
            commonLastWordSwitcher,
            beginningTeamLabel,
            chooseDeckLabel,
//            beginingTeamPullDown,
//            chooseDeckPullDown,
//

            dropDownTeam,
            dropDownDeck,
            
            nextButton
        ]

        view.addSubview(container)
        
        allElements.forEach({v in container.addSubview(v)})
        allElements.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})
        setupActions()
        setupConstraints()
        

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setupConstraints()
    }
    
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
            
        ].forEach({constraint in constraint.isActive = true})

//        guard let navController = self.navigationController else {
//            print("no nav controller")
//            return
//        }

//        bigSettingsLabelButton.layer.zPosition = -1;
//        container.backgroundColor = .purple
//        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(bigSettingsLabelButton)
        NSLayoutConstraint.activate([
            
            
//            bigSettingsLabelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            bigSettingsLabelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            bigSettingsLabelButton.heightAnchor.constraint(equalToConstant: 10),
//            bigSettingsLabelButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
//            container.topAnchor.constraint(equalTo: view.topAnchor),
//            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            //container.widthAnchor.constraint(equalToConstant: 100)
        ])

    }
    
    func setupActions() {
        bigSettingsLabelButton.addTarget(self, action: #selector(onSettingsButtonClicked), for: .touchUpInside)
    }
    
    
    @IBAction func onSettingsButtonClicked() {
        output.onSettingsButtonClicked(settingsViewController: self)
    }
    
}

extension SettingsViewController: SettingsViewInput {
}
    


extension UINavigationBar {

    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        let navigationNormalHeight: CGFloat = 44
        let navigationExtendHeight: CGFloat = 84
        
        var barHeight: CGFloat = navigationNormalHeight
    
        if size.height == navigationExtendHeight {
            barHeight = size.height
        }
    
        let newSize: CGSize = CGSize(width: self.frame.size.width, height: barHeight)
        return newSize
    }
}
