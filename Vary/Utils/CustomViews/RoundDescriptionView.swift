//
//  RoundDescriptionView.swift
//  Vary
//
//  Created by user207433 on 12/11/21.
//

import Foundation
import UIKit

protocol RoundDescriptionViewDelegagate: AnyObject {
    func viewTouched()
}

class RoundDescriptionView: UIView {
    
    var roundType: RoundType?
    
    
    let tipMessage: String =  "Нажми на экран, когда будешь готов"
    

    weak var delegate: RoundDescriptionViewDelegagate?
    
    private let roundDescriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = VaryColors.secondaryColor
        view.font = view.font.withSize(25)
        return view
    }()
    
    private let tipMessageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = VaryColors.textColor
        view.font = view.font.withSize(15)
        return view
    }()
    

    init() {
        super.init(frame: .zero)
        self.roundType = .describe
        setupConstrains()
    }
    
    init(roundType type:RoundType) {
        super.init(frame: .zero)
        self.roundType = type
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstrains()
    }
    
    
    private func setupConstrains() {
        guard let roundType = roundType else {
            return
        }
        addSubview(roundDescriptionLabel)
        addSubview(tipMessageLabel)
        
        let roundIcon = roundType.getIcon()!
        let roundImage = UIImageView()
        let templateImage = roundIcon.withRenderingMode(.alwaysTemplate)
        roundImage.image = templateImage
        roundImage.tintColor = VaryColors.primaryColor

        

        addSubview(roundImage)
        
        
        roundDescriptionLabel.text = roundType.getRoundDesciption()
        roundImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        roundImage.tintColor = VaryColors.primaryColor
        
        tipMessageLabel.text = tipMessage
        
        NSLayoutConstraint.activate([
            roundImage.topAnchor.constraint(equalTo: topAnchor),
            roundImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundImage.widthAnchor.constraint(equalToConstant: 100),
            roundImage.heightAnchor.constraint(equalToConstant: 100),
//            roundImage.bottomAnchor.constraint(equalTo: roundDescriptionLabel.topAnchor),
            
            roundDescriptionLabel.topAnchor.constraint(equalTo: roundImage.bottomAnchor),
            roundDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundDescriptionLabel.bottomAnchor.constraint(equalTo: tipMessageLabel.topAnchor),
            
            tipMessageLabel.topAnchor.constraint(equalTo: roundDescriptionLabel.bottomAnchor),
            tipMessageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tipMessageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            tipMessageLabel.heightAnchor.constraint(equalToConstant: 15),
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.viewTouched))
        gesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(gesture)
        
    }
    
    
    @objc func viewTouched(sender : UITapGestureRecognizer) {
        delegate?.viewTouched()
    }

}
