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
        return view
    }()
    
    private let tipMessageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = VaryColors.additionalColor
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
        
        let roundIcon = roundType.getIcon()
        let roundImage = UIImageView(image: roundIcon)
        addSubview(roundImage)
        
        
        roundDescriptionLabel.text = roundType.getRoundDesciption()
        roundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            roundImage.topAnchor.constraint(equalTo: topAnchor),
            roundImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundImage.bottomAnchor.constraint(equalTo: roundDescriptionLabel.topAnchor),
            
            roundDescriptionLabel.topAnchor.constraint(equalTo: roundImage.topAnchor),
            roundDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            roundDescriptionLabel.bottomAnchor.constraint(equalTo: tipMessageLabel.topAnchor),
            
            tipMessageLabel.topAnchor.constraint(equalTo: roundDescriptionLabel.bottomAnchor),
            tipMessageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tipMessageLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.viewTouched))
        gesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(gesture)
        
    }
    
    
    @objc func viewTouched(sender : UITapGestureRecognizer) {
        delegate?.viewTouched()
    }

}
