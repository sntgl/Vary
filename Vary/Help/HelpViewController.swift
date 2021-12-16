//
//  HelpViewController.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class HelpViewController: UIViewController {
	private let output: HelpViewOutput
    
    private let container = UIView()
    
    private let scrollView =  UIScrollView()
    
    private let contentView = UIView()
    
//    private let labelHeadingTop = UILabel()
//    private let headerLabelsList = [UILabel](repeating: UILabel(), count: 5)
//    private let textLabelsList = [UILabel](repeating: UILabel(), count: 5)
    
    private var headerLabelsList: [UILabel] = []
    private var textLabelsList:[UILabel] = []
    
    private let headerText: [String] = ["Авторская игра для компаний от четырех человек.",
                                        "Режим Объясни словами",
                                        "Режим Покажи жестами",
                                        "Режим Объясни одним словом",
                                        "Дополнительные указания",
                                        ]
    private let labelText: [String] = ["Игроки разбиваются на команды от двух человек. Выбирается размер колоды карт.\nДалее нужно за выбранное время объяснить своей команде как можно больше слов указанным способом. Следующая команда получает колоду со словами, необъясненными ранее в текущем режиме игры.\nПосле того как карты закончатся, начальная колода перемешивается, и команды объясняют те же слова, но новым способом:",
                                       "Рассказывай истории, приводи примеры, вспоминай песни и придумывай подсказки, но не объясняй буквы, не используй однокоренные (например качели - качаются) и иностранные слова.\nПохожие игры - Шляпа, Alias.",
                                        "Двигай любой частью тела, принимай любые позы, рисуй жестами, но не издавай ни звука, не указывай на какие-либо предметы и не показывай буквы.\nПохожие игры - Крокодил.",
                                        "Ты можешь сказать лишь одно слово, ведь за два раунда все игроки выучили колоду карт. Будь внимателен: это слово нельзя изменить, и исправить свою ошибку можно лишь сбросив карту. Не забывай про запрет на однокоренные и иностранные слова.",
                                        "Побеждает команда, набравшая наибольшее количество очков по итогам всех раундов.\nИгроки могут включить режим общего последнего слова: по истечении времени карточку может отгадать любая команда.\nЗадание от игроков может быть любым, начиная от правды или действия, заканчивая кукареканьем под столом."]
    
    init(output: HelpViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        setupSubviews()
        setupStyle()
        setupConstraints()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navController = self.navigationController as? CustomNavigationController else {
                  print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
                  return
              }
        navController.myTitle = "Vary"
    }
    
    
    
    func setupSubviews() {
        

        view.addSubview(container)
        container.addSubview(scrollView)
        scrollView.addSubview(contentView)
        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        headerLabelsList.forEach({v in scrollView.addSubview(v)})
//        headerLabelsList.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})
//
//
//        textLabelsList.forEach({v in scrollView.addSubview(v)})
//        textLabelsList.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})
//
  
        
    }
    
    func setupStyle() {
        
        view.backgroundColor = VaryColors.primaryColor
        container.backgroundColor = VaryColors.surfaceColor
    }
    
    func setupConstraints() {
 
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//
            scrollView.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            
            
        ].forEach({constraint in constraint.isActive = true})
       
        scrollView.isScrollEnabled = true
//        self.scrollView.contentSize = self.contentView.bounds.size*2
//        let testLabel = headerLabelsList[0]
//
//        testLabel.translatesAutoresizingMaskIntoConstraints = false
//        testLabel.numberOfLines = 0
//        testLabel.textColor = VaryColors.textColor
//        testLabel.font = testLabel.font.withSize(45)
//        testLabel.text = headerText[0]
//        scrollView.addSubview(testLabel)
//
//               [
//                testLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
//                testLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//                testLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//                testLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//
//
//               ].forEach({constraint in constraint.isActive = true})

        

        for i in 0..<self.headerText.count{
            let headerLabel = UILabel()
            let textLabel = UILabel()
////            headerLabelsList[i].topAnchor.constraint(equalTo: textLabelsList[0].topAnchor, constant: 5),
//            headerLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
//            textLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
    
            contentView.addSubview(headerLabel)
            contentView.addSubview(textLabel)
            
            headerLabelsList.append(headerLabel)
            textLabelsList.append(textLabel)
            if i == 0 {
                headerLabelsList[0].topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//                headerLabelsList[0].bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                headerLabelsList[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
                headerLabelsList[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
                headerLabelsList[0].centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                headerLabelsList[0].widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
//                headerLabelsList[0].heightAnchor.constraint(equalToConstant: 30).isActive = true

                textLabelsList[0].topAnchor.constraint(equalTo: headerLabelsList[0].bottomAnchor, constant: 15).isActive = true
                textLabelsList[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
                textLabelsList[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
                textLabelsList[0].centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                textLabelsList[0].widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
//                textLabelsList[0].heightAnchor.constraint(equalToConstant: 30).isActive = true
                
                headerLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
                headerLabelsList[i].numberOfLines = 0
                headerLabelsList[i].textColor = VaryColors.secondaryColor
                headerLabelsList[i].font = headerLabelsList[i].font.withSize(30)
                headerLabelsList[i].text = headerText[i]
                headerLabelsList[i].textAlignment = .left
                
                textLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
                textLabelsList[i].numberOfLines = 0
                textLabelsList[i].textColor = VaryColors.textColor
                textLabelsList[i].font = textLabelsList[i].font.withSize(15)
                textLabelsList[i].text = labelText[i]
                textLabelsList[i].textAlignment = .left
    //
            
            }else{
//            ].forEach({constraint in constraint.isActive = true})
                headerLabelsList[i].topAnchor.constraint(equalTo: textLabelsList[i-1].bottomAnchor, constant: 15).isActive = true
//                headerLabelsList[0].bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                headerLabelsList[i].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
                headerLabelsList[i].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
                headerLabelsList[i].centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                headerLabelsList[i].widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
//                headerLabelsList[0].heightAnchor.constraint(equalToConstant: 30).isActive = true

                textLabelsList[i].topAnchor.constraint(equalTo: headerLabelsList[i].bottomAnchor, constant: 10).isActive = true
                textLabelsList[i].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
                textLabelsList[i].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15).isActive = true
                textLabelsList[i].centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
                textLabelsList[i].widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
                
                headerLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
                headerLabelsList[i].numberOfLines = 1
                headerLabelsList[i].textColor = VaryColors.secondaryColor
                headerLabelsList[i].font = headerLabelsList[i].font.withSize(25)
                headerLabelsList[i].text = headerText[i]
                headerLabelsList[i].textAlignment = .left
                
                textLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
                textLabelsList[i].numberOfLines = 0
                textLabelsList[i].textColor = VaryColors.textColor
                textLabelsList[i].font = textLabelsList[i].font.withSize(15)
                textLabelsList[i].text = labelText[i]
                textLabelsList[i].textAlignment = .left
            }

//
        }
        contentView.frame.size.height += 300
        scrollView.contentSize = contentView.frame.size
        
        
        
    }
    
    
}

extension HelpViewController: HelpViewInput {
}
