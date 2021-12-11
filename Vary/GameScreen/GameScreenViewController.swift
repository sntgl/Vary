//
//  GameScreenViewController.swift
//  Vary
//
//  Created by Даниил Волков on 10.12.2021.
//  
//

import UIKit

final class GameScreenViewController: UIViewController {
	private let output: GameScreenViewOutput

    // Views
    
    private let timerLabel = UILabel()
    private let guessedLabel = UILabel()
    private let wordsMissedLabel = UILabel()
    private let roundScoreLabel = UILabel()
    private let roundSubDescriptionLabel = UILabel()
    
    private let roundDesciptionView: RoundDescriptionView = RoundDescriptionView()
    // End Views
    
    
    
    
    init(output: GameScreenViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        guard let navController = self.navigationController as? CustomNavigationController else {
                  print("No Navigation Controller for class:" + NSStringFromClass(self.classForCoder))
                  return
              }
        navController.myTitle = "Настройки игры"
    }
    
    
	override func viewDidLoad() {
		super.viewDidLoad()
//        setupSubviews()
//        setupStyle()
	}
}

extension GameScreenViewController: GameScreenViewInput {
}
