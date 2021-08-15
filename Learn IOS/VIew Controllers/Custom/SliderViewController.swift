//
//  SliderViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/11.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class SliderViewController: UIViewController {

    private let backButton = LeButton()
    private let sliderValueLabel = UILabel()
    private let centerSlider = CircularSlider()
    private let topSlider = CircularSlider()
    private let leftSlider = CircularSlider()
    private let rightSlider = CircularSlider()
    private let bottomSlider = CircularSlider()
    
    private var constraints = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViews()
    }
    
    @objc func onBackButtonClick(_ sender:UIButton) {
        UIImpactFeedbackGenerator().impactOccurred()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Initial Views
extension SliderViewController {
    private func initViews() {
        initBackButton()
        initSliderValueLabel()
        initCenterSlider()
        initTopSlider()
        initBottomSlider()
        initLeftSlider()
        initRightSlider()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initBackButton() {
        view.addSubview(backButton)
        backButton.cornerType = .round
        backButton.setImage(withName: "ArrowBack", tintColor: UIColor(hexString: "#585858"))
        backButton.setBackgroundColor(UIColor(hexString: "#C8C8C840"))
        backButton.addTarget(self, action: #selector(onBackButtonClick), for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48))
        constraints.append(backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36))
        constraints.append(backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12))
        constraints.append(backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor))
    }
    
    private func initSliderValueLabel() {
        view.addSubview(sliderValueLabel)
        sliderValueLabel.textAlignment = .center
        
        sliderValueLabel.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(sliderValueLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60))
        constraints.append(sliderValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
    }
    
    private func initCenterSlider() {
        centerSlider.beginAngle = 220
        centerSlider.angle = 260
        centerSlider.clockwise = true
        centerSlider.delegate = self
        view.addSubview(centerSlider)
        
        centerSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(centerSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5))
        constraints.append(centerSlider.heightAnchor.constraint(equalTo: centerSlider.widthAnchor))
        constraints.append(centerSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(centerSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor))
    }
    
    private func initTopSlider() {
        topSlider.beginAngle = 160
        topSlider.angle = 140
        topSlider.clockwise = true
        topSlider.delegate = self
        view.addSubview(topSlider)
        
        topSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(topSlider.heightAnchor.constraint(equalTo: centerSlider.heightAnchor, multiplier: 1.2))
        constraints.append(topSlider.widthAnchor.constraint(equalTo: topSlider.heightAnchor))
        constraints.append(topSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(topSlider.centerYAnchor.constraint(equalTo: centerSlider.centerYAnchor))
    }
    
    private func initBottomSlider() {
        view.addSubview(bottomSlider)
        bottomSlider.beginAngle = 200
        bottomSlider.angle = 140
        bottomSlider.delegate = self
        
        bottomSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(bottomSlider.heightAnchor.constraint(equalTo: centerSlider.heightAnchor, multiplier: 1.4))
        constraints.append(bottomSlider.widthAnchor.constraint(equalTo: bottomSlider.heightAnchor))
        constraints.append(bottomSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(bottomSlider.centerYAnchor.constraint(equalTo: centerSlider.centerYAnchor))
    }
    
    private func initLeftSlider() {
        view.addSubview(leftSlider)
        leftSlider.beginAngle = 250
        leftSlider.angle = 140
        leftSlider.clockwise = true
        leftSlider.delegate = self
        
        leftSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(leftSlider.widthAnchor.constraint(equalTo: centerSlider.widthAnchor, multiplier: 1.6))
        constraints.append(leftSlider.heightAnchor.constraint(equalTo: leftSlider.widthAnchor))
        constraints.append(leftSlider.centerXAnchor.constraint(equalTo: centerSlider.centerXAnchor))
        constraints.append(leftSlider.centerYAnchor.constraint(equalTo: centerSlider.centerYAnchor))
    }
    
    private func initRightSlider() {
        view.addSubview(rightSlider)
        rightSlider.beginAngle = 290
        rightSlider.angle = 140
        rightSlider.delegate = self
        
        rightSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(rightSlider.widthAnchor.constraint(equalTo: centerSlider.widthAnchor, multiplier: 1.8))
        constraints.append(rightSlider.heightAnchor.constraint(equalTo: rightSlider.widthAnchor))
        constraints.append(rightSlider.centerXAnchor.constraint(equalTo: centerSlider.centerXAnchor))
        constraints.append(rightSlider.centerYAnchor.constraint(equalTo: centerSlider.centerYAnchor))
    }
}

//MARK: Update Views
extension SliderViewController {
    private func updateViews() {}
}

extension SliderViewController: CircularSliderDelegate {
    func onChanged(_ value: Float, slider: CircularSlider) {
        var sliderName = ""
        if topSlider == slider {
            sliderName = "Top Slider"
        } else if bottomSlider == slider {
            sliderName = "Bottom Slider"
        } else if leftSlider == slider {
            sliderName = "Left Slider"
        } else if rightSlider == slider {
            sliderName = "Right Slider"
        } else if centerSlider == slider {
            sliderName = "Center Slider"
        }
        
        sliderValueLabel.text = "\(sliderName), Value: \(value)"
    }
}
