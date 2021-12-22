//
//  AppSettingsViewController.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class AppSettingsViewController: UIViewController {
	private let output: AppSettingsViewOutput

    
    private let container = UIView()
    
    private let soundSettingsButton = SettingsButton(labelText: "Звуки в игре", imageOn: UIImage(named: "MusicOnIcon")!, imageOff: UIImage(named: "MusicOffIcon")!)
    
    private let updateSettingsButton = SettingsButton(labelText: "Проверять обновления", imageOn: UIImage(named: "SystemUpdateIcon")!, imageOff: UIImage(named: "MobileOffIcon")!)
    
    init(output: AppSettingsViewOutput) {
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
        navController.myTitle = "Settings"
    }
    
    func setupSubviews() {
        

        view.addSubview(container)
        
        container.addSubview(soundSettingsButton)
        container.addSubview(updateSettingsButton)
    }
    
    func setupStyle() {
        
        view.backgroundColor = VaryVars.Colors.primaryColor
        container.backgroundColor = VaryVars.Colors.surfaceColor
    }
    
    
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        soundSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        updateSettingsButton.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            soundSettingsButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            soundSettingsButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            soundSettingsButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            soundSettingsButton.heightAnchor.constraint(equalToConstant: 100),
            soundSettingsButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            updateSettingsButton.topAnchor.constraint(equalTo: soundSettingsButton.bottomAnchor, constant: 10),
            updateSettingsButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            updateSettingsButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -5),
            updateSettingsButton.heightAnchor.constraint(equalToConstant: 100),
            updateSettingsButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            
            
        ].forEach({constraint in constraint.isActive = true})

    }
    
}

extension AppSettingsViewController: AppSettingsViewInput {
}
