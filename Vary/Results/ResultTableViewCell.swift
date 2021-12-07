//
//  ResultTableViewCell.swift
//  Vary
//
//  Created by Даниил Волков on 05.12.2021.
//

import UIKit

class ResultTableViewCell: UITableViewCell {


    private let wordLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(wordLabel)
        wordLabel.text = "слово"
        wordLabel.textColor = .white

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
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            //            wordLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            wordLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.9),
            wordLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95),
            wordLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ].forEach({constraint in constraint.isActive = true})
    }
}

private extension ResultTableViewCell {
    enum Colors {
        static let primaryColor = UIColor(named: "Primary")!
        static let surfaceColor = UIColor(named: "Surface")!
    }
}

