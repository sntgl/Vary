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
    
    var gameInfo = ["аббревиатура", "абитуриент", "абонемент", "аборт", "абракадабра", "абсент", "авария", "авгур", "автокефалия", "агальма", "агломерат", "аграф", "адепт", "адмирал", "ажиотаж", "азарт", "акант", "аквилон", "аккламация", "акколада", "аккордеон", "акрибия", "акробатика", "акростих", "аксиология", "акупунктура", "акут", "акушер", "алеаторика", "алембик", "алиби", "алкоголь", "аллергия"]

    var guessedCardsIndex = [2,3,4,5]
    
    
    init(output: ScoresViewOutput) {
        self.output = output
//        self.gameInfo = gameInfo
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
//        nextButton.addTarget(self, action: #selector(onNextButtonClicked), for: .touchUpInside)
        
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
        scoresTableView.separatorColor = .black
        scoresTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        scoresTableView.separatorStyle = .singleLine
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
        selectGuessedWords()
        
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
    
    
    func selectGuessedWords(){
        
//        for guessedWordIndex in self.gameInfo!.guessedCardsIndex {
        for guessedWordIndex in self.guessedCardsIndex {
            let indexPath = IndexPath(row: guessedWordIndex, section: 0)
            scoresTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            scoresTableView.delegate?.tableView!(scoresTableView, didSelectRowAt: indexPath)
        }
//        var values : [Int] = []
//        let selected_indexPaths = scoresTableView.indexPathsForSelectedRows
//        for indexPath in selected_indexPaths! {
//            let cell = scoresTableView.cellForRow(at: indexPath)
//            values.append(indexPath.row)
//        }
//
    }
    
}

extension ScoresViewController: ScoresViewInput {
}

extension ScoresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.gameInfo!.cardsForGame.cards.count
        return self.gameInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScoreTableViewCell
       
//        self.tableView.separatorStyle = UITableViewSeparatorStyleNone;

//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none
        
//        cell.wordLabel.text = self.gameInfo!.cardsForGame.cards[indexPath.row].name
        cell.wordLabel.text = self.gameInfo[indexPath.row]
        if self.guessedCardsIndex.contains(indexPath.row){
            cell.wordLabel.textColor = VaryColors.primaryColor
          
        }

//        cell.cross.tag = indexPath.row
//        cell.cross.addTarget(self, action: #selector(removeRowButtonClicked), for: .touchUpInside)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
//        cell.addGestureRecognizer(tapGesture)
//        cell.isUserInteractionEnabled = true
//        cell.tag = indexPath.row;

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
//            if indexPath == lastVisibleIndexPath {
//                // do here...
//            }
//        }
        if self.guessedCardsIndex.contains(indexPath.row){
    
            cell.setSelected(true, animated: false)
        }
//
//        if self.guessedCardsIndex.contains(indexPath.row) {
//            self.tableView(tableView, didSelectRowAt: indexPath)
//        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScoreTableViewCell
//        cell.tintColor = VaryColors.secondaryColor
        print(String(indexPath.section))
        let cell = tableView.cellForRow(at: indexPath) as! ScoreTableViewCell
        if cell.isSelected{
            cell.wordLabel.textColor = VaryColors.textColor
            cell.setSelected(false, animated: false)
        }else{
            cell.wordLabel.textColor = VaryColors.primaryColor
            cell.setSelected(true, animated: false)
        }
        
        
     
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

private extension ScoresViewController {
  
}

