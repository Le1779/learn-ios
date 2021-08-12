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
    private let centerSlider = RoundSlider()
    private let topSlider = RoundSlider()
    private let leftSlider = RoundSlider()
    private let rightSlider = RoundSlider()
    private let bottomSlider = RoundSlider()
    
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
    
    private func initCenterSlider() {
        view.addSubview(centerSlider)
        centerSlider.color = UIColor(hexString: "#880E4F80")
        centerSlider.beginAngle = 0
        centerSlider.endAngle = 359
        
        centerSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(centerSlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5))
        constraints.append(centerSlider.heightAnchor.constraint(equalTo: centerSlider.widthAnchor))
        constraints.append(centerSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(centerSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor))
    }
    
    private func initTopSlider() {
        view.addSubview(topSlider)
        topSlider.color = UIColor(hexString: "#3E272380")
        topSlider.beginAngle = 20
        topSlider.endAngle = 160
        
        topSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(topSlider.heightAnchor.constraint(equalTo: centerSlider.heightAnchor, multiplier: 0.6))
        constraints.append(topSlider.widthAnchor.constraint(equalTo: topSlider.heightAnchor, multiplier: 2))
        constraints.append(topSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(topSlider.bottomAnchor.constraint(equalTo: centerSlider.centerYAnchor))
    }
    
    private func initBottomSlider() {
        view.addSubview(bottomSlider)
        bottomSlider.color = UIColor(hexString: "#BF360C80")
        bottomSlider.beginAngle = 200
        bottomSlider.endAngle = 340
        
        bottomSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(bottomSlider.heightAnchor.constraint(equalTo: centerSlider.heightAnchor, multiplier: 0.7))
        constraints.append(bottomSlider.widthAnchor.constraint(equalTo: bottomSlider.heightAnchor, multiplier: 2))
        constraints.append(bottomSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(bottomSlider.topAnchor.constraint(equalTo: centerSlider.centerYAnchor))
    }
    
    private func initLeftSlider() {
        view.addSubview(leftSlider)
        leftSlider.color = UIColor(hexString: "#004D4080")
        leftSlider.beginAngle = 110
        leftSlider.endAngle = 250
        
        leftSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(leftSlider.widthAnchor.constraint(equalTo: centerSlider.widthAnchor, multiplier: 0.8))
        constraints.append(leftSlider.heightAnchor.constraint(equalTo: leftSlider.widthAnchor, multiplier: 2))
        constraints.append(leftSlider.centerYAnchor.constraint(equalTo: centerSlider.centerYAnchor))
        constraints.append(leftSlider.trailingAnchor.constraint(equalTo: centerSlider.centerXAnchor))
    }
    
    private func initRightSlider() {
        view.addSubview(rightSlider)
        rightSlider.color = UIColor(hexString: "#1A237E80")
        rightSlider.beginAngle = 290
        rightSlider.endAngle = 70
        
        rightSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(rightSlider.widthAnchor.constraint(equalTo: centerSlider.widthAnchor, multiplier: 0.9))
        constraints.append(rightSlider.heightAnchor.constraint(equalTo: rightSlider.widthAnchor, multiplier: 2))
        constraints.append(rightSlider.centerYAnchor.constraint(equalTo: centerSlider.centerYAnchor))
        constraints.append(rightSlider.leadingAnchor.constraint(equalTo: centerSlider.centerXAnchor))
    }
    
    
}

//MARK: Update Views
extension SliderViewController {
    private func updateViews() {}
}
