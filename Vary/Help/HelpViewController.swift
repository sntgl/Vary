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
    
//    private let labelHeadingTop = UILabel()
    private let headerLabelsList = [UILabel](repeating: UILabel(), count: 5)
    private let textLabelsList = [UILabel](repeating: UILabel(), count: 5)
    private let headerText: [String] = ["Авторская игра для компаний от четырех человек.", "Режим Объясни словами", "Режим Покажи жестами", ]
    private let labelText: [String] = ["\tИгроки разбиваются на команды от двух человек. Выбирается размер колоды карт.\n\tДалее нужно за выбранное время объяснить своей команде как можно больше слов указанным способом. Следующая команда получает колоду со словами, необъясненными ранее в текущем режиме игры.\n\tПосле того как карты закончатся, начальная колода перемешивается, и команды объясняют те же слова, но новым способом:",
                                       "\tРассказывай истории, приводи примеры, вспоминай песни и придумывай подсказки, но не объясняй буквы, не используй однокоренные (например качели - качаются) и иностранные слова.\n\tПохожие игры - Шляпа, Alias.",]
    
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
        
        headerLabelsList.forEach({v in scrollView.addSubview(v)})
        headerLabelsList.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})

        textLabelsList.forEach({v in scrollView.addSubview(v)})
        textLabelsList.forEach({v in v.translatesAutoresizingMaskIntoConstraints = false})
    }
    
    func setupStyle() {
        
        view.backgroundColor = VaryColors.primaryColor
        container.backgroundColor = VaryColors.surfaceColor
    }
    
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: container.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            
        ].forEach({constraint in constraint.isActive = true})

        
        for i in 0..<self.headerLabelsList.count{
//            headerLabelsList[i].topAnchor.constraint(equalTo: textLabelsList[0].topAnchor, constant: 5),
            headerLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
            textLabelsList[i].translatesAutoresizingMaskIntoConstraints = false
            if i == 0 {
                headerLabelsList[0].topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                headerLabelsList[0].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
                headerLabelsList[0].trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
                headerLabelsList[0].centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
                
                textLabelsList[0].topAnchor.constraint(equalTo: headerLabelsList[0].bottomAnchor, constant: 5).isActive = true
                textLabelsList[0].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
                textLabelsList[0].trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
                textLabelsList[0].centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            }else{
//            ].forEach({constraint in constraint.isActive = true})
            headerLabelsList[i].topAnchor.constraint(equalTo: textLabelsList[i-1].bottomAnchor).isActive = true
            headerLabelsList[i].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            headerLabelsList[i].trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            headerLabelsList[i].centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            
            textLabelsList[i].topAnchor.constraint(equalTo: headerLabelsList[i].bottomAnchor, constant: 5).isActive = true
            textLabelsList[i].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            textLabelsList[i].trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            textLabelsList[i].centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            }
        }
        
    }
    
    
}

extension HelpViewController: HelpViewInput {
}
