//
//  TeamTableViewCell.swift
//  Vary
//
//  Created by Даниил Волков on 17.11.2021.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    let nameTF = UITextField()

    let cross = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        nameTF.text = "Команда 1"
        nameTF.textColor = .white
        nameTF.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 24)
        //        cross.image = UIImage(named: "Cross", in: .none, with: .none)
        contentView.addSubview(nameTF)
        contentView.addSubview(cross)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        nameTF.translatesAutoresizingMaskIntoConstraints = false

        nameTF.translatesAutoresizingMaskIntoConstraints = false
        [
            nameTF.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameTF.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameTF.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            //            nameTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ].forEach({constraint in constraint.isActive = true})

        cross.translatesAutoresizingMaskIntoConstraints = false
        [
            cross.topAnchor.constraint(equalTo: contentView.topAnchor),
            cross.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cross.leadingAnchor.constraint(equalTo: nameTF.trailingAnchor),
            cross.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ].forEach({constraint in constraint.isActive = true})
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
