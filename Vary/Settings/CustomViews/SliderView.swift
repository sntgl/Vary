//
//  SliderView.swift
//  Vary
//
//  Created by user207433 on 11/14/21.
//

import UIKit

protocol ISliderViewDelegate: AnyObject {
    func valueDidChange(nweValue: Float)
}

class SliderView: UIView {
    
    var titleLabelString: String?
    var valueLabelString: String?
    var valueIntString: Int? {
        didSet{
            let value = valueIntString ?? 0
            valueLabel.text = String(value) + " " + (valueLabelString ?? "")
        }
    }
    
    weak var delegate: ISliderViewDelegate?
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = UIColor(named: "Primary")!
        return view
    }()
    
    private let valueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 0
        view.textColor = UIColor(named: "Primary")!
        return view
    }()
    
    private let slider: UISlider = {
       let view = UISlider()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.maximumValue = 100
        view.minimumValue = 0
        view.value = 0
        view.isUserInteractionEnabled = true
        return view
        
    }()


    init(titleLabelString leftlabel :String,valueLabelString rightlabel: String) {
        super.init(frame: .zero)
        titleLabelString = leftlabel
        valueLabelString = rightlabel
        setupConstrains()
        slider.addTarget(self, action: #selector(sliderValueChange(_:)), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstrains()
        slider.addTarget(self, action: #selector(sliderValueChange(_:)), for: .valueChanged)
    }
    
    
    private func setupConstrains() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(slider)
        
        titleLabel.text = titleLabelString
        valueLabel.text = "0 " + valueLabelString!
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: slider.topAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            slider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            slider.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: valueLabel.trailingAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor),
            slider.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc
    private func sliderValueChange(_ sender: UISlider) {
        delegate?.valueDidChange(nweValue: sender.value)
        valueIntString = Int(sender.value)
    }
}
