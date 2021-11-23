//
//  RadioGroupView.swift
//  Vary
//
//  Created by user207433 on 11/23/21.
//

import UIKit

class RadioGroupView: UIView {
    
    private let stackView =  UIStackView()
    
    var multipleChoice: Bool = false
    private var defaultChecked: Int?
    
    private var radioTitles: [String] = []
    
    var radioButtonsList: [RadioButton] = []
    
    init(titles values:[String], defaultChecked num: Int? = nil) {
        super.init(frame: .zero)
        radioTitles = values
        
        defaultChecked = num
        setupRadioGroup()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupRadioGroup(){
        
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing   = 10.0

        let radioButtonHeight = CGFloat(20)
        
        for (index, title) in radioTitles.enumerated(){
            
            let radioButton = RadioButton(id:index, radioLabel: title)
            radioButton.delegate = self
            radioButton.translatesAutoresizingMaskIntoConstraints = false
            radioButton.heightAnchor.constraint(equalToConstant: radioButtonHeight).isActive = true
            stackView.addArrangedSubview(radioButton)
            radioButtonsList.append(radioButton)

        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        let radioGroupHeigt = CGFloat(radioTitles.count)*(radioButtonHeight+stackView.spacing)
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: radioGroupHeigt),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
        ])
        
        if let num = defaultChecked{
            radioButtonsList[num].isPressed = true
        }
        
    }
    
}


extension RadioGroupView: RadioButtonDelegate{
    func radioButtonPressed(_ button: RadioButton) {
        if !multipleChoice {
            for btn in radioButtonsList{
                if button.id != btn.id{
                    btn.isPressed = false
                }
            }
            
        }
    }
    
    
}

