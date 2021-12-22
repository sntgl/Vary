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

    var teamsArray = ["Команда 1", "Команда 2"]

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
//        title = "Команды"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
        navigationController?.setNavigationBarHidden(false, animated: true)
        teamsTableView.register(TeamTableViewCell.self, forCellReuseIdentifier: "Cell")

//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backToStartViewController))

        navigationController?.setNavigationBarHidden(false, animated: true)

        teamsTableView.delegate = self
        teamsTableView.dataSource = self

        setupSubviews()
        setupStyle()
  }

    override func viewWillAppear(_ animated: Bool) {
        guard let navController = self.navigationController as? CustomNavigationController else {
                  print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
                  return
              }
        navController.myTitle = VaryVars.Strings.Teams
    }

    
    
    func setupSubviews() {
        view.addSubview(container)
        [
            continueButton,
            teamsTableView,
            addButton
        ].forEach({subView in container.addSubview(subView)})
    }

    func setupStyle(){
        view.backgroundColor = VaryVars.Colors.primaryColor
        container.backgroundColor = VaryVars.Colors.surfaceColor

        continueButton.setTitle(VaryVars.Strings.Next, for: .normal)
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = VaryVars.Colors.primaryColor

//        backButton.setImage(UIImage(systemName: "arrowtriangle.backward.fill"), for: .normal)
        backButton.setTitle(VaryVars.Strings.Back, for: .normal)
        backButton.tintColor = VaryVars.Colors.surfaceColor
        backButton.addTarget(self, action: #selector(backToStartViewController), for: .touchUpInside)

        addButton.configuration = buttonConf
        addButton.setTitle(VaryVars.Strings.Add, for: .normal)
//        addButton.setImage(UIImage(systemName: "cross"), for: .normal)
        addButton.addTarget(self, action: #selector(addRowButtonClicked), for: .touchUpInside)

        teamsTableView.backgroundColor = VaryVars.Colors.surfaceColor
        teamsTableView.alwaysBounceVertical = false;
        teamsTableView.tableFooterView = addButton

//        teamsLabel.text = "Команды"
        teamsLabel.textColor = .white
//        teamsLabel.font = teamsLabel.font.withSize(30)
        teamsLabel.textAlignment = .center
        teamsLabel.isEnabled = true
        teamsLabel.layer.cornerRadius = 0
        teamsLabel.backgroundColor = VaryVars.Colors.primaryColor
        teamsLabel.clipsToBounds = true

        teamsLabel.layer.cornerRadius = 20
        teamsLabel.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]

        continueButton.configuration = buttonConf
        continueButton.setTitle(VaryVars.Strings.Next, for: .normal)
        continueButton.backgroundColor = VaryVars.Colors.primaryColor
        continueButton.isEnabled = true
        continueButton.layer.cornerRadius = 0
        continueButton.clipsToBounds = true
        continueButton.layer.cornerRadius = 30
        continueButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        continueButton.addTarget(self, action: #selector(goToSettingsView), for: .touchUpInside)
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
            continueButton.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            continueButton.widthAnchor.constraint(equalTo: container.widthAnchor),
        ].forEach({constraint in constraint.isActive = true})


        teamsTableView.translatesAutoresizingMaskIntoConstraints = false
        [
            teamsTableView.topAnchor.constraint(equalTo:  container.topAnchor, constant: 10),
            teamsTableView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -10),
            teamsTableView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            teamsTableView.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.9),
        ].forEach({constraint in constraint.isActive = true})
    }

    @IBAction func backToStartViewController() {
        output.didBackToStartViewControllerButton()
    }
    
    @IBAction func goToSettingsView(){
        output.didContinue()
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
        let alert = UIAlertController(title: VaryVars.Strings.TeamName, message: nil, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.text = self.teamsArray[sender.view!.tag]
            textField.keyboardType = .default
        }

        let okAction = UIAlertAction(title: VaryVars.Strings.Save, style: .default, handler: { (action) -> Void in
            if alert.textFields![0].text == "" {
                self.teamsArray[sender.view!.tag] = VaryVars.Strings.Name
            } else {
                self.teamsArray[sender.view!.tag] = (alert.textFields?[0].text)!
            }
            self.teamsTableView.reloadData()
        } )
        let returnAction = UIAlertAction(title: VaryVars.Strings.Cancel, style: .default, handler: nil)
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
        teamsArray.append(VaryVars.Strings.Team + " \(teamsArray.count + 1)")
        self.teamsTableView.reloadData()
    }
}
