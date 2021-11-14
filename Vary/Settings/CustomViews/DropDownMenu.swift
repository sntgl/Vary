//
//  DropDownMenu.swift
//  Vary
//
//  Created by user207433 on 11/14/21.
//

import Foundation
import UIKit

class DropDownMenu: UIView {
    
    //MARK: - Properties
    var dataSourse: [String]?
    
    private(set) var curentCurrency: String?
    private var tableViewHeightValue: CGFloat = 100
    private var tableViewHeightConstraint: NSLayoutConstraint!
    private let tableViewIndentifier = "tableViewIdentifier"
    
    private var currencyTextField: UITextField	= {
        let text = UITextField()
        text.placeholder = ""
        text.isUserInteractionEnabled = false
        text.isEnabled = true
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .white
        text.attributedPlaceholder = NSAttributedString(string: " ", attributes: [NSAttributedString.Key.foregroundColor: UIColor(named:"textBright")])
        text.textColor = .white
        return text
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "triangle"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var invoiceNameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .brown
        return view
    }()
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4.5
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0).cgColor
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "Surface")
        return tableView
    }()
    
    //MARK: - Init
    override init(frame: CGRect = CGRect()) {
        super.init(frame: frame)
        configureConstraints()
        configureTableView()
        configureGestures()
        isUserInteractionEnabled = true
    }

    init(textPlaceholder: String){
        super.init(frame: CGRect())
        configureConstraints()
        configureTableView()
        configureGestures()
        currencyTextField.placeholder = textPlaceholder
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Func
    
    override func layoutSubviews() {
        currencyTextField.backgroundColor = UIColor(named: "Surface")
        currencyTextField.textColor = UIColor(named: "textBright")
        super.layoutSubviews()
    }
    
    func showError(message: String) {
//        currencyTextField.showError(message: message)
    }
    
    private func configureConstraints() {
        addSubview(containerView)
        containerView.addSubview(invoiceNameContainer)
        invoiceNameContainer.addSubview(currencyTextField)
        invoiceNameContainer.addSubview(imageView)
        containerView.addSubview(tableView)

        containerView.anchor(top: safeAreaLayoutGuide.topAnchor,
                             leading: safeAreaLayoutGuide.leadingAnchor,
                             bottom: safeAreaLayoutGuide.bottomAnchor,
                             trailing: safeAreaLayoutGuide.trailingAnchor)
        
        invoiceNameContainer.anchor(top: containerView.topAnchor,
                              leading: containerView.leadingAnchor,
                              trailing: containerView.trailingAnchor)
        
        currencyTextField.anchor(top: invoiceNameContainer.topAnchor,
                         leading: invoiceNameContainer.leadingAnchor,
                         bottom: invoiceNameContainer.bottomAnchor)
        
        imageView.anchor(
            trailing: invoiceNameContainer.trailingAnchor,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8),
            size: CGSize(width: 15, height: 15),
            centerY: currencyTextField.centerYAnchor)
        
        tableView.anchor(top: invoiceNameContainer.bottomAnchor,
                         leading: containerView.leadingAnchor,
                         bottom: containerView.bottomAnchor,
                         trailing: containerView.trailingAnchor)
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            tableViewHeightConstraint
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewIndentifier)
    }
    
    private func configureGestures() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showHideTableView))
        tap.cancelsTouchesInView = false
        invoiceNameContainer.addGestureRecognizer(tap)
    }
    
    @objc private func showHideTableView(_ sender: UITapGestureRecognizer) {
        if tableViewHeightConstraint.constant == 0 {
            showTableView()
        } else {
            hideTableView()
        }
    }
    
    private func showTableView() {
        tableViewHeightConstraint.constant = tableViewHeightValue
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / 2))
            self.superview?.layoutIfNeeded()
        })
    }
    
    private func hideTableView() {
        tableViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: { [unowned self] in
            self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
            self.superview?.layoutIfNeeded()
        })
    }
}


extension DropDownMenu: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        curentCurrency = dataSourse?[indexPath.row]
        currencyTextField.text = curentCurrency
        hideTableView()
    }
}

extension DropDownMenu: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewIndentifier, for: indexPath)
        cell.textLabel?.text = dataSourse?[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor(named: "Surface")
        cell.textLabel?.textColor = .white
        return cell
    }
}
