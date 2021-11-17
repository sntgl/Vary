//
//  TeamsViewController.swift
//  Vary
//
//  Created by Александр Тагилов on 09.11.2021.
//
//

import UIKit

final class TeamsViewController: UIViewController {
    private let output: TeamsViewOutput

    private let teamsTableView = UITableView()

    private let continueButton = UIButton()
    private var backButton = UIBarButtonItem()

    private var buttonConf = UIButton.Configuration.filled()

    private let container = UIView()

    init(output: TeamsViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Команды"
        navigationController?.setNavigationBarHidden(false, animated: true)
        teamsTableView.register(TeamTableViewCell.self, forCellReuseIdentifier: "Cell")

        teamsTableView.delegate = self
        teamsTableView.dataSource = self

        setupSubviews()
        setupStyle()
    }

    func setupSubviews() {
        view.addSubview(container)
        [
            continueButton,
            teamsTableView
        ].forEach({subView in container.addSubview(subView)})

        backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backToStartViewController))
        backButton.image = UIImage(systemName: "arrowtriangle.backward.fill")
        backButton.tintColor = Colors.surfaceColor

        navigationItem.leftBarButtonItem = backButton
    }

    func setupStyle(){
        view.backgroundColor = Colors.primaryColor
        container.backgroundColor = Colors.surfaceColor

        continueButton.setTitle("Далее", for: .normal)
        buttonConf.buttonSize = .large

        teamsTableView.separatorColor = .yellow
        teamsTableView.backgroundColor = Colors.surfaceColor
        teamsTableView.alwaysBounceVertical = false;

        buttonConf.baseBackgroundColor = Colors.primaryColor

        continueButton.configuration = buttonConf


        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 40)!]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupConstraints()
    }

    func setupConstraints(){
        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ].forEach({constraint in constraint.isActive = true})

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        [
            continueButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10),
            continueButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9),
        ].forEach({constraint in constraint.isActive = true})


        teamsTableView.translatesAutoresizingMaskIntoConstraints = false
        [
            teamsTableView.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            teamsTableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10),
            teamsTableView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            teamsTableView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9),
        ].forEach({constraint in constraint.isActive = true})

    }

    @IBAction func backToStartViewController() {
        output.didBackToStartViewControllerButton()
    }
}

extension TeamsViewController: TeamsViewInput {
}

extension TeamsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TeamTableViewCell

        cell.nameTF.text = "Команда \(indexPath.row + 1)"

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}

private extension TeamsViewController {
    enum Colors {
        static let primaryColor = UIColor(named: "Primary")!
        static let surfaceColor = UIColor(named: "Surface")!
    }
}
