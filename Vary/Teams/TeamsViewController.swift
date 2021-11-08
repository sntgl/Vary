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
        navigationController?.setNavigationBarHidden(false, animated: true) //показывает кнопочку назад
            //по сути этот NavigationBar надо как-то кастомизировать и тебе нужно этим тоже заняться
        view.backgroundColor = .red //для тестирования сделал так
	}
}

extension TeamsViewController: TeamsViewInput {
}
