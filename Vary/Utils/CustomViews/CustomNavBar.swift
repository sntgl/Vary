//
//  CustomNavBar.swift
//  Vary
//
//  Created by user207433 on 12/8/21.
//

import UIKit

class CustomNavigationController: UINavigationController{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // Colors
    private let primaryColor = VaryVars.Colors.primaryColor
    private let surfaceColor = VaryVars.Colors.surfaceColor
    private let secondaryColor = VaryVars.Colors.secondaryColor
    private let additionalColor = VaryVars.Colors.additionalColor
    private let textColor = VaryVars.Colors.textColor
    
    
    var myTitleButton: UIButton?
//    var timerLabel: UILabel?
    
    var myTitle: String? {
        didSet{
            guard let btn = myTitleButton else{
                return
            }
            btn.setTitle(myTitle, for: .normal)
        }
    }
    
//    var timerString: String? {
//        didSet{
//            guard let lbl = timerLabel else{
//                return
//            }
//            lbl.text = timerString
//        }
//    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.setupNavController()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupNavController()
    }

    
    
    
    func setupNavController(){

        var navBarButtonConf = UIButton.Configuration.filled()
        navBarButtonConf.buttonSize = .large
        navBarButtonConf.baseBackgroundColor = VaryVars.Colors.primaryColor

        let navBarLabelButton = UIButton()
        navBarLabelButton.configuration = navBarButtonConf
//        navBarLabelButton.setTitle(title, for: .normal)
        navBarLabelButton.isEnabled = true
        navBarLabelButton.layer.cornerRadius = 0
        navBarLabelButton.backgroundColor = primaryColor
        navBarLabelButton.clipsToBounds = true
        navBarLabelButton.layer.cornerRadius = 10
        navBarLabelButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        navBarLabelButton.titleLabel?.textColor = textColor
        // bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(45)
//        navBarLabelButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Light", size: 45)
        myTitleButton = navBarLabelButton
        
        // navBar SubView
        self.navigationBar.addSubview(navBarLabelButton)
        navBarLabelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navBarLabelButton.topAnchor.constraint(equalTo: self.navigationBar.topAnchor),
            navBarLabelButton.widthAnchor.constraint(equalTo: self.navigationBar.widthAnchor),
            navBarLabelButton.centerXAnchor.constraint(equalTo: self.navigationBar.centerXAnchor),
            ])

        // Send button to back
        self.navigationBar.sendSubviewToBack(navBarLabelButton)
        navBarLabelButton.layer.zPosition = -1;
        navBarLabelButton.isUserInteractionEnabled = false

    }
    
    
}
