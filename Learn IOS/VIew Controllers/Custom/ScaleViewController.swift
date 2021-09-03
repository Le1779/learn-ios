//
//  ScaleViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/15.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class ScaleViewController: UIViewController {

    private let backButton = LeButton()
    private let lineScale = Scale()
    private let circularScale = Scale()
    private let leftSlider = CircularSlider()
    
    private var constraints = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    @objc func onBackButtonClick(_ sender:UIButton) {
        UIImpactFeedbackGenerator().impactOccurred()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Initial Views
extension ScaleViewController {
    private func initViews() {
        initBackButton()
        initLineScale()
        initCircularScale()
        initLeftSlider()
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
    
    private func initLineScale() {
        lineScale.scaleColor = UIColor(hexString: "#E5E5E5")
        lineScale.scaleWidth = 3
        lineScale.units = 0.05
        view.addSubview(lineScale)
        
        lineScale.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(lineScale.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8))
        constraints.append(lineScale.heightAnchor.constraint(equalToConstant: 36))
        constraints.append(lineScale.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(lineScale.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 48))
        
    }
    
    private func initCircularScale() {
        circularScale.scaleColor = UIColor(hexString: "#E5E5E5")
        circularScale.scaleWidth = 3
        circularScale.units = 1/10
        circularScale.beginAngle = 220
        circularScale.angle = 260
        circularScale.scaleType = .circular
        view.addSubview(circularScale)
        
        circularScale.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(circularScale.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8))
        constraints.append(circularScale.heightAnchor.constraint(equalTo: circularScale.widthAnchor))
        constraints.append(circularScale.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        constraints.append(circularScale.topAnchor.constraint(equalTo: lineScale.bottomAnchor, constant: 48))
    }
    
    private func initLeftSlider() {
        view.addSubview(leftSlider)
        leftSlider.beginAngle = 220
        leftSlider.angle = 260
        leftSlider.clockwise = true
        
        leftSlider.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(leftSlider.widthAnchor.constraint(equalTo: circularScale.widthAnchor, multiplier: 0.87))
        constraints.append(leftSlider.heightAnchor.constraint(equalTo: circularScale.heightAnchor))
        constraints.append(leftSlider.centerYAnchor.constraint(equalTo: circularScale.centerYAnchor))
        constraints.append(leftSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor))
    }
}
