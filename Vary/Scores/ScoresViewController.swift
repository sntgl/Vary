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
    
    var gameInfo: GameInfo?

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
        
        scoresTableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: "Cell")
        scoresTableView.delegate = self
        scoresTableView.dataSource = self


        scoresTableView.alwaysBounceVertical             = false;
        scoresTableView.backgroundColor = VaryColors.surfaceColor
        scoresTableView.tintColor = VaryColors.surfaceColor
        scoresTableView.separatorColor = .black
        scoresTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        scoresTableView.separatorStyle = .singleLine
        scoresTableView.separatorColor = VaryColors.secondaryColor

        view.addSubview(container)
        container.addSubview(scoresTableView)
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
        [
            scoresTableView.topAnchor.constraint(equalTo:  container.topAnchor, constant: 20),
            scoresTableView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            scoresTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoresTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
        ].forEach({constraint in constraint.isActive = true})
    }
}

extension ScoresViewController: ScoresViewInput {
}

extension ScoresViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScoreTableViewCell
        cell.selectionStyle = .blue
//        cell.backgroundColor = .clear
//        cell.selectionStyle = .none

//        cell.nameLabel.text = teamsArray[indexPath.row]
//
//        cell.cross.tag = indexPath.row
//        cell.cross.addTarget(self, action: #selector(removeRowButtonClicked), for: .touchUpInside)
//
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
//        cell.addGestureRecognizer(tapGesture)
//        cell.isUserInteractionEnabled = true
//        cell.tag = indexPath.row;

        return cell
    }

    
//    override func tablec
//    @objc
//    func nameLabelTapped(_ sender: UITapGestureRecognizer){
//        let alert = UIAlertController(title: "Название команды", message: nil, preferredStyle: .alert)
//        alert.addTextField { (textField:UITextField) in
//            textField.text              = self.teamsArray[sender.view!.tag]
//            textField.keyboardType      = .default
//        }
//
//        let okAction = UIAlertAction(title: "Сохранить", style: .default, handler: { (action) -> Void in
//            if alert.textFields![0].text == "" {
//                self.teamsArray[sender.view!.tag] = "Название"
//            } else {
//                self.teamsArray[sender.view!.tag] = (alert.textFields?[0].text)!
//            }
//            self.teamsTableView.reloadData()
//        } )
//        let returnAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
//        alert.addAction(returnAction)
//        alert.addAction(okAction)
//        self.present(alert, animated: true, completion: nil)
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

private extension ScoresViewController {
  
}

