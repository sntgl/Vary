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
	}
}

extension AppSettingsViewController: AppSettingsViewInput {
}
