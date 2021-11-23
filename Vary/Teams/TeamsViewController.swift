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

    private let backButton = UIButton()
    private let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))

    private let teamsLabel = UILabel()

    private var buttonConf = UIButton.Configuration.filled()

    private let container = UIView()

    private var teamsArray = ["Команда 1", "Команда 2"]

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

        navigationController?.setNavigationBarHidden(true, animated: false)

        teamsTableView.delegate = self
        teamsTableView.dataSource = self

        setupSubviews()
        setupStyle()
    }

    func setupSubviews() {
        view.addSubview(container)
        [
            continueButton,
            teamsTableView,
            teamsLabel,
            backButton,
            addButton
        ].forEach({subView in container.addSubview(subView)})
    }

    func setupStyle(){
        view.backgroundColor = Colors.primaryColor
        container.backgroundColor = Colors.surfaceColor

        continueButton.setTitle("Далее", for: .normal)
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = Colors.primaryColor

        backButton.setImage(UIImage(systemName: "arrowtriangle.backward.fill"), for: .normal)
        backButton.tintColor = Colors.surfaceColor
        backButton.addTarget(self, action: #selector(backToStartViewController), for: .touchUpInside)

        addButton.configuration = buttonConf
        addButton.setTitle("Добавить", for: .normal)
//        addButton.setImage(UIImage(systemName: "cross"), for: .normal)
        addButton.addTarget(self, action: #selector(addRowButtonClicked), for: .touchUpInside)

        teamsTableView.backgroundColor = Colors.surfaceColor
        teamsTableView.alwaysBounceVertical = false;
        teamsTableView.tableFooterView = addButton

        teamsLabel.text = "Команды"
        teamsLabel.textColor = .white
//        teamsLabel.font = teamsLabel.font.withSize(30)
        teamsLabel.textAlignment = .center
        teamsLabel.isEnabled = true
        teamsLabel.layer.cornerRadius = 0
        teamsLabel.backgroundColor = Colors.primaryColor
        teamsLabel.clipsToBounds = true
        teamsLabel.layer.cornerRadius = 30
        teamsLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        continueButton.configuration = buttonConf
        continueButton.setTitle("Далее", for: .normal)
        continueButton.isEnabled = true
        continueButton.layer.cornerRadius = 0
        continueButton.clipsToBounds = true
        continueButton.layer.cornerRadius = 30
        continueButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        continueButton.titleLabel?.font =  continueButton.titleLabel?.font.withSize(25)
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

        teamsLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            teamsLabel.topAnchor.constraint(equalTo: container.topAnchor),
            teamsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            teamsLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            teamsLabel.heightAnchor.constraint(equalTo: continueButton.heightAnchor)
        ].forEach({constraint in constraint.isActive = true})

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        [
            continueButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            continueButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            continueButton.widthAnchor.constraint(equalTo: container.widthAnchor),
        ].forEach({constraint in constraint.isActive = true})


        teamsTableView.translatesAutoresizingMaskIntoConstraints = false
        [
            teamsTableView.topAnchor.constraint(equalTo:  teamsLabel.bottomAnchor, constant: 10),
            teamsTableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10),
            teamsTableView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            teamsTableView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9),
        ].forEach({constraint in constraint.isActive = true})

        backButton.translatesAutoresizingMaskIntoConstraints = false
        [
            backButton.topAnchor.constraint(equalTo: container.topAnchor),
            backButton.bottomAnchor.constraint(equalTo: teamsLabel.bottomAnchor),
            backButton.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            backButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.2)
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
        teamsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TeamTableViewCell

        cell.nameLabel.text = teamsArray[indexPath.row]
        cell.cross.tag = indexPath.row
        cell.cross.addTarget(self, action: #selector(removeRowButtonClicked), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
        cell.addGestureRecognizer(tapGesture)
        cell.isUserInteractionEnabled = true
        cell.tag = indexPath.row;

        return cell
    }

    @objc
    func nameLabelTapped(_ sender: UITapGestureRecognizer){
        let alert = UIAlertController(title: "Название команды", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.text = self.teamsArray[sender.view!.tag]
            textField.keyboardType = .default
        }

        let okAction = UIAlertAction(title: "Сохранить", style: .default, handler: { (action) -> Void in
            if alert.textFields![0].text == "" {
                self.teamsArray[sender.view!.tag] = "Название"
            } else {
                self.teamsArray[sender.view!.tag] = (alert.textFields?[0].text)!
            }
            self.teamsTableView.reloadData()
        } )
        let returnAction = UIAlertAction(title: "Отмена", style: .default, handler: nil)
        alert.addAction(returnAction)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    @objc func removeRowButtonClicked(sender : UIButton!) {
        if teamsArray.count > 2 {
            teamsArray.remove(at: sender.tag)
            self.teamsTableView.reloadData()
        }
    }

    @objc func addRowButtonClicked(sender : UIButton!) {
        teamsArray.append("Команда \(teamsArray.count + 1)")
        self.teamsTableView.reloadData()
    }
}

private extension TeamsViewController {
    enum Colors {
        static let primaryColor = UIColor(named: "Primary")!
        static let surfaceColor = UIColor(named: "Surface")!
    }
}
