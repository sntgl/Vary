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
    
    
    let tipMessage: String =  VaryVars.Strings.TouchWordWhenWillBeReady
    

    weak var delegate: RoundDescriptionViewDelegagate?
    
    private let roundDescriptionLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = VaryVars.Colors.secondaryColor
        view.font = view.font.withSize(25)
        return view
    }()
    
    private let tipMessageLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = VaryVars.Colors.textColor
        view.font = view.font.withSize(15)
        return view
    }()
    
    private let roundImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = VaryVars.Colors.primaryColor
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
    
    private func setupSubViewsInfo(){
        guard let roundType = roundType else {
            return
        }
        let roundIcon = roundType.getIcon()!
        let templateImage = roundIcon.withRenderingMode(.alwaysTemplate)
        roundImage.image = templateImage
        roundImage.tintColor = VaryVars.Colors.primaryColor
        
        roundDescriptionLabel.text = roundType.getRoundDesciption()
        
        tipMessageLabel.text = tipMessage
        
    }
    
    
    private func setupConstrains() {
  
        addSubview(roundDescriptionLabel)
        addSubview(tipMessageLabel)
        addSubview(roundImage)
        roundImage.clipsToBounds = false
        roundImage.contentMode = .scaleAspectFill
        setupSubViewsInfo()
        
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
//        print("TOUCHED!")
        delegate?.viewTouched()
    }
    
    func changeRoundType(toType type:RoundType){
        self.roundType = type
        setupSubViewsInfo()
    }

}
