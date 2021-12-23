//
//  RadioButton.swift
//  Vary
//
//  Created by user207433 on 11/23/21.
//

import UIKit


protocol RadioButtonDelegate: AnyObject {
    func radioButtonPressed(_ button: RadioButton)
}


class RadioButton: UIView {
    
    var id: Int = 0
    
    weak var delegate: RadioButtonDelegate?
    
    private let stackView =  UIStackView()
    
    private let radioImage: UIImage = UIImage(systemName: "circle")!
    private let radioPressedImage: UIImage = UIImage(systemName: "circle.fill")!
    
    var isPressed: Bool = false {
        didSet{
            let currentImage = isPressed ? radioPressedImage : radioImage
            radioButton.setImage(currentImage, for: .normal)
        }
    }
    
    private let radioLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = VaryVars.Colors.primaryColor
        view.numberOfLines = 1
        return view
    }()

    
    private let radioButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.setImage(UIImage(systemName: "circle"), for: .normal)
        return view
    }()

    init(id buttonId: Int, radioLabel value:String) {
        super.init(frame: .zero)
        id = buttonId
        radioLabel.text = value
        setupStack()
        setupConstrains()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupStack(){
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = 5.0
        
        stackView.addArrangedSubview(radioLabel)
        stackView.addArrangedSubview(radioButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(pressedButton))
        self.addGestureRecognizer(gesture)
        
        addSubview(stackView)
    }
    
    private func setupConstrains() {
        stackView.addArrangedSubview(radioButton)
        stackView.addArrangedSubview(radioLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        radioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            radioButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            radioButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
           // radioButton.heightAnchor.constraint(equalToConstant: 15),
            
            
            radioLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 5),
            radioLabel.centerYAnchor.constraint(equalTo: radioButton.centerYAnchor),
           // radioLabel.heightAnchor.constraint(equalToConstant: 15),
            
           // stackView.heightAnchor.constraint(equalToConstant: 18),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    @objc func pressedButton(sender : UITapGestureRecognizer) {
        isPressed = !isPressed
        delegate?.radioButtonPressed(self)
    }
    
}
