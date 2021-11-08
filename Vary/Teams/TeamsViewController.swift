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
	}
}

extension TeamsViewController: TeamsViewInput {
}
