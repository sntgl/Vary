//
//  StartViewController.swift
//  Vary
//
//  Created by Александр Тагилов on 07.11.2021.
//  
//

import UIKit

final class StartViewController: UIViewController {
	private let output: StartViewOutput
    
    private let primaryColor = UIColor(named: "Primary")!
    private let surfaceColor = UIColor(named: "Surface")!
    private let secondaryColor = UIColor(named: "Secondary")!
    private let additionalColor = UIColor(named: "Additional")!
    
    private let iconsSize = CGFloat(60)
    
    private let container = UIView()
    
    private let helpButton = UIButton(type: .custom)
    private var helpImage = UIImage(named: "HelpImg")!
    
    private let settingsButton = UIButton(type: .custom)
    private var settingsImage = UIImage(named: "SettingsImg")!
    
    private var buttonConf = UIButton.Configuration.filled()
    private var disabledButtonConf = UIButton.Configuration.filled()
    
    private let newGameButton = UIButton()
    private let continueGameButton = UIButton()
    

    init(output: StartViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


	override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
        setupStyle()
        setupActions()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupStyle() {

        view.backgroundColor = primaryColor
        
        container.backgroundColor = surfaceColor
        
        helpImage = helpImage.withTintColor(primaryColor)
        helpButton.setImage(helpImage, for: .normal)
        
        settingsImage = settingsImage.withTintColor(primaryColor)
        settingsButton.setImage(settingsImage, for: .normal)
        
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = primaryColor

        disabledButtonConf.buttonSize = .large
        disabledButtonConf.baseBackgroundColor = additionalColor
        
        newGameButton.configuration = buttonConf
        newGameButton.setTitle("Новая игра", for: .normal)
        
        continueGameButton.configuration = buttonConf
        continueGameButton.setTitle("Продолжить игру", for: .normal)
        continueGameButton.isEnabled = true
        
    }
    
    func setupSubviews() {
        view.addSubview(container)
        [
            helpButton,
            settingsButton,
            newGameButton,
            continueGameButton
        ].forEach({v in container.addSubview(v)})
        
    }
    
    func setupConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        [
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ].forEach({constraint in constraint.isActive = true})
        
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        [
            helpButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            helpButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            helpButton.widthAnchor.constraint(equalToConstant: iconsSize),
            helpButton.heightAnchor.constraint(equalToConstant: iconsSize)
        ].forEach({constraint in constraint.isActive = true})
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        [
            settingsButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            settingsButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            settingsButton.widthAnchor.constraint(equalToConstant: iconsSize),
            settingsButton.heightAnchor.constraint(equalToConstant: iconsSize)
        ].forEach({constraint in constraint.isActive = true})
        
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        [
            newGameButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -80),
            newGameButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
        ].forEach({constraint in constraint.isActive = true})
        
        continueGameButton.translatesAutoresizingMaskIntoConstraints = false
        [
            continueGameButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            continueGameButton.bottomAnchor.constraint(equalTo: newGameButton.topAnchor, constant: -12),
            continueGameButton.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8),
        ].forEach({constraint in constraint.isActive = true})
        
    }
    
    func setupActions() {
        newGameButton.addTarget(self, action: #selector(onStartNewGameButtonClicked), for: .touchUpInside)
    }
    
    @IBAction func onStartNewGameButtonClicked() {
        output.didTapStartNewGameButton()
    }

}

extension StartViewController: StartViewInput {
    
}
