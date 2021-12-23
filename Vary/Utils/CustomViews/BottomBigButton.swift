//
//  RadioButton.swift
//  Vary
//
//  Created by user207433 on 11/23/21.
//

import UIKit


class BottomBigButton: UIButton {

    private var buttonText: String?
    private var buttonConf = UIButton.Configuration.filled()
    
    init(label text:String) {
        super.init(frame: .zero)
        buttonText = text
        setupStyle()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupStyle(){
        buttonConf.buttonSize = .large
        buttonConf.baseBackgroundColor = VaryVars.Colors.primaryColor
        
        self.configuration = buttonConf
        self.setTitle(buttonText, for: .normal)
        self.isEnabled = true
        self.layer.cornerRadius = 0
        self.backgroundColor = VaryVars.Colors.primaryColor
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.titleLabel?.textColor = VaryVars.Colors.textColor
        self.titleLabel?.font =  self.titleLabel?.font.withSize(25)
    }
    
}
