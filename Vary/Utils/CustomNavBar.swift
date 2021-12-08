//
//  CustomNavBar.swift
//  Vary
//
//  Created by user207433 on 12/8/21.
//

import UIKit

class CustomNavBar{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // Colors
    private let primaryColor = VaryColors.primaryColor
    private let surfaceColor = VaryColors.surfaceColor
    private let secondaryColor = VaryColors.secondaryColor
    private let additionalColor = VaryColors.additionalColor
    private let textColor = VaryColors.textColor
    
//
//    private var title: String = ""
//    private var navBar : UINavigationBar?
//
//    init(currentNavBar navBar:UINavigationBar, title label: String) {
//        super.init(frame: .zero)
//        self.title = label
//        self.navBar = navBar
//        self.setupNavController()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//
//    static func setupNavController(navTitle title:String){
////
////        guard let navBar = self.navBar else{
////            return
////        }
////
////        for views in navBar.subviews {
////            views.removeFromSuperview()
////        }
////
//        guard let navController = self.navigationController else {
//            return
//        }
//
//        var navBarButtonConf = UIButton.Configuration.filled()
//        navBarButtonConf.buttonSize = .large
//        navBarButtonConf.baseBackgroundColor = VaryColors.primaryColor
//
//        let navBarLabelButton = UIButton()
//        navBarLabelButton.configuration = navBarButtonConf
//        navBarLabelButton.setTitle(title, for: .normal)
//        navBarLabelButton.isEnabled = true
//        navBarLabelButton.layer.cornerRadius = 0
//        navBarLabelButton.backgroundColor = primaryColor
//        navBarLabelButton.clipsToBounds = true
//        navBarLabelButton.layer.cornerRadius = 10
//        navBarLabelButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        navBarLabelButton.titleLabel?.textColor = textColor
//        // bigSettingsLabelButton.titleLabel?.font =  bigSettingsLabelButton.titleLabel?.font.withSize(45)
//        navBarLabelButton.titleLabel?.font =  UIFont(name: "HelveticaNeue-Light", size: 45)
//
//        // navBar SubView
//        navBar.addSubview(navBarLabelButton)
//        navBarLabelButton.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            navBarLabelButton.topAnchor.constraint(equalTo: self.topAnchor),
//            navBarLabelButton.widthAnchor.constraint(equalTo: self.widthAnchor),
//            ])
//
//        // Send button to back
//        navBar.sendSubviewToBack(navBarLabelButton)
//        navBarLabelButton.layer.zPosition = -1;
//        navBarLabelButton.isUserInteractionEnabled = false
//
//    }
}
