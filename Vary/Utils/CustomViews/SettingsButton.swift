//
//  SettingsButton.swift
//  Vary
//
//  Created by user207433 on 12/15/21.
//

import Foundation
import UIKit


class SettingsButton: UIView{
    
    private let settingsHintLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = VaryVars.Colors.textColor
        view.font = view.font.withSize(25)
        return view
    }()
    
    private let settingsImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = VaryVars.Colors.primaryColor
        return view
    }()
    
    private var isPressed: Bool = false
    private var imageOn: UIImage?
    private var imageOff: UIImage?
    
    


    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstrains()
    }
    
    init(labelText text:String, imageOn: UIImage, imageOff: UIImage) {
        super.init(frame: .zero)
        self.settingsHintLabel.text = text
        self.imageOn = imageOn
        self.imageOff = imageOff
        setupConstrains()
    }
    
    private func setupConstrains() {
  
        addSubview(settingsHintLabel)
        addSubview(settingsImage)
     
//        setupSubViewsInfo()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(pressedButton))
        self.addGestureRecognizer(gesture)
        
        let templateImage = imageOn!.withRenderingMode(.alwaysTemplate)
        settingsImage.image = templateImage
        settingsImage.tintColor = VaryVars.Colors.primaryColor
        settingsImage.clipsToBounds = false
        settingsImage.contentMode = .scaleAspectFill
        
        settingsHintLabel.translatesAutoresizingMaskIntoConstraints = false
        settingsImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsHintLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            settingsHintLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingsHintLabel.heightAnchor.constraint(equalToConstant: 30),
        
//            roundImage.bottomAnchor.constraint(equalTo: roundDescriptionLabel.topAnchor),
            settingsImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            settingsImage.widthAnchor.constraint(equalToConstant: 50),
            settingsImage.heightAnchor.constraint(equalToConstant: 50),
            settingsImage.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        

        
    }
    
    
    @objc func pressedButton(sender : UITapGestureRecognizer) {
        isPressed = !isPressed
        var templateImage: UIImage?;
        if isPressed {
            templateImage = imageOn!.withRenderingMode(.alwaysTemplate)
        }else{
            templateImage = imageOff!.withRenderingMode(.alwaysTemplate)
  
        }
        settingsImage.image = templateImage!
        settingsImage.tintColor = VaryVars.Colors.primaryColor
        settingsImage.clipsToBounds = false
        settingsImage.contentMode = .scaleAspectFill
    }
    
}
