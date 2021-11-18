//
//  TeamTableViewCell.swift
//  Vary
//
//  Created by Даниил Волков on 17.11.2021.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    var nameLabel = UILabel()

//    let cross = UIImageView()

    public let cross = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews(){
        contentView.addSubview(nameLabel)
        contentView.addSubview(cross)
    }

    private func setupStyle(){
        nameLabel.text = "Команда 1"
        nameLabel.textColor = UIColor(named: "TextBright")!
        nameLabel.font = UIFont(name: "HelveticaNeue-Italic", size: 24)
        nameLabel.isUserInteractionEnabled = true
        let nameLabelTap = UITapGestureRecognizer(target: self, action: #selector(nameLabelTapped))
        nameLabelTap.numberOfTapsRequired = 2
        nameLabel.addGestureRecognizer(nameLabelTap)
        cross.setImage(UIImage(named: "delete", in: .none, with: .none), for: .normal)
    }

    override func layoutSubviews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            //            nameTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ].forEach({constraint in constraint.isActive = true})

        cross.translatesAutoresizingMaskIntoConstraints = false
        [
            cross.topAnchor.constraint(equalTo: contentView.topAnchor),
            cross.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cross.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
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

    @objc
    func nameLabelTapped(_ sender: UITapGestureRecognizer){
        let alert = UIAlertController(title: "Название команды", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.text = self.nameLabel.text
            textField.keyboardType = .default
        }

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            if alert.textFields![0].text == "" {
                self.nameLabel.text = "Название"
            } else {
                self.nameLabel.text = alert.textFields?[0].text
            }
        } )
        alert.addAction(okAction)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
