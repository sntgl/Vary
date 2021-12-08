//
//  ResultsViewController.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//  
//

import UIKit

final class ResultsViewController: UIViewController {
    private let output: ResultsViewOutput

    private let scoresTableView = UITableView()

    private let container = UIView()

    init(output: ResultsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
        title = "Набранные баллы"


    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavController(navTitle: "Набранные баллы")
    }
    
    
    func setupNavController(navTitle title:String){
        guard let navController = self.navigationController else {
            print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
            return
        }
        
        navController.setNavigationBarHidden(false, animated: true)

        for views in navController.navigationBar.subviews {
            views.removeFromSuperview()
        }


        // Add Button to NavBar
        var navBarButtonConf = UIButton.Configuration.filled()
        navBarButtonConf.buttonSize = .large
        navBarButtonConf.baseBackgroundColor = VaryColors.primaryColor

        let navBarLabelButton = UIButton()
        navBarLabelButton.configuration = navBarButtonConf
        navBarLabelButton.setTitle(title, for: .normal)
        navBarLabelButton.isEnabled = true
        navBarLabelButton.layer.cornerRadius = 0
        navBarLabelButton.backgroundColor = VaryColors.primaryColor
        navBarLabelButton.clipsToBounds = true
        navBarLabelButton.layer.cornerRadius = 10
        navBarLabelButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        navBarLabelButton.titleLabel?.textColor = VaryColors.textColor
        // bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(45)
        navBarLabelButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Light", size: 45)

        // navBar SubView
        navController.navigationBar.addSubview(navBarLabelButton)
        navBarLabelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navBarLabelButton.topAnchor.constraint(equalTo: navController.navigationBar.topAnchor),
            navBarLabelButton.widthAnchor.constraint(equalTo: navController.navigationBar.widthAnchor),
            ])

        // Send button to back
        navController.navigationBar.sendSubviewToBack(navBarLabelButton)
        navBarLabelButton.layer.zPosition = -1;
        navBarLabelButton.isUserInteractionEnabled = false

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor        = Colors.primaryColor

        scoresTableView.register(ScoreTableViewCell.self, forCellReuseIdentifier: "Cell")
        scoresTableView.delegate = self
        scoresTableView.dataSource = self


        scoresTableView.alwaysBounceVertical             = false;
        scoresTableView.backgroundColor = Colors.surfaceColor
        scoresTableView.tintColor = Colors.surfaceColor


        container.backgroundColor = Colors.surfaceColor

        view.addSubview(container)
        container.addSubview(scoresTableView)
        container.backgroundColor = Colors.surfaceColor

        setupConstraints()
        scoresTableView.separatorColor = .black
        scoresTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        scoresTableView.separatorStyle = .singleLine
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

extension ResultsViewController: ResultsViewInput {
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ScoreTableViewCell

        cell.backgroundColor = .clear
        cell.selectionStyle = .none

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
}

private extension ResultsViewController {
    enum Colors {
        static let primaryColor = UIColor(named: "Primary")!
        static let surfaceColor = UIColor(named: "Surface")!
    }
}

