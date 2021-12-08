//
//  DropDownMenu.swift
//  Vary
//
//  Created by user207433 on 11/14/21.
//

import Foundation
import UIKit

class DropDownMenu: UITextField  {

    
    public var selectedRowTitle:String?
    public var selectedRow:Int = 0
    
    private var menuContent: [String] = ["Placeholder"]
    
    private let teamLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "Primary")!
        return view
    }()

    
    private let dropButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        return view
    }()

    //
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

    
    init(menuContent labelsValue:[String]) {
         super.init(frame: .zero)
         menuContent = labelsValue
         teamLabel.text = menuContent[0]
         selectedRowTitle = menuContent[0]
         setupConstrains()
         setUpPicker()
        
    }

//

    private func setUpPicker(){
        let elementPicker = UIPickerView()
        elementPicker.delegate = self
        
        self.inputView = elementPicker
        createToolbar()
    }
    
    func createToolbar() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        self.inputAccessoryView = toolbar
   
    }
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
    private func setupConstrains() {
        addSubview(teamLabel)
        addSubview(dropButton)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:255, green:225/255, blue:227/255, alpha: 1).cgColor
        
        NSLayoutConstraint.activate([

            teamLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            teamLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            teamLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 3),
            
            dropButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            // HArdCOre!!
            dropButton.heightAnchor.constraint(equalToConstant: 9),
            dropButton.widthAnchor.constraint(equalToConstant: 9),
            //
            dropButton.centerYAnchor.constraint(equalTo: teamLabel.centerYAnchor),
            
            self.heightAnchor.constraint(equalTo: teamLabel.heightAnchor, constant: 5)
        
        ])
        self.sendSubviewToBack(dropButton)
        
        
    }
    
    
}

extension DropDownMenu: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return menuContent.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return menuContent[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedElement = menuContent[row]
        teamLabel.text = selectedElement
        self.selectedRowTitle = selectedElement
        self.selectedRow = row
    }

    
}
