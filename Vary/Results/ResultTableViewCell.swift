//
//  ResultTableViewCell.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//

import UIKit

class ResultTableViewCell: UITableViewCell {


    let teamLabel = UILabel()
    let scoreLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(teamLabel)
        contentView.addSubview(scoreLabel)
        teamLabel.textColor = VaryColors.textColor
        scoreLabel.textColor = VaryColors.textColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            //            wordLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            teamLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            teamLabel.widthAnchor.constraint(equalToConstant: 15),
            teamLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            teamLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            teamLabel.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor),
            
            scoreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            scoreLabel.widthAnchor.constraint(equalToConstant: 10),
            scoreLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            scoreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,  constant: -10),
            
//            wordLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ].forEach({constraint in constraint.isActive = true})
    }
}

private extension ResultTableViewCell {
    enum Colors {
        static let primaryColor = UIColor(named: "Primary")!
        static let surfaceColor = UIColor(named: "Surface")!
    }
}

