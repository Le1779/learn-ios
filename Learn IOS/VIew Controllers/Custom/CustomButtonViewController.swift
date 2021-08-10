//
//  CustomButtonViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/25.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class CustomButtonViewController: UIViewController {

    private var constraints = [NSLayoutConstraint]()
    
    private let backButton = LeButton()
    private let lightButton = LeButton()
    private let fanButton = LeButton()
    private let onOffButton = OnOffButton()
    private let uvcButton = UVCButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViews()
    }
    
    @objc func onClick(_ sender:UIButton) {
        onOffButton.isOn = !onOffButton.isOn
        uvcButton.isOn = !uvcButton.isOn
        UIImpactFeedbackGenerator().impactOccurred()
    }
}

//MARK: Initial Views
extension CustomButtonViewController {
    private func initViews() {
        initBackButton()
        initLightButton()
        initFanButton()
        initOnOffButton()
        initUVCButton()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initBackButton() {
        view.addSubview(backButton)
        backButton.cornerType = .round
        backButton.setImage(withName: "ArrowBack", tintColor: UIColor(hexString: "#585858"))
        backButton.setBackgroundColor(UIColor(hexString: "#C8C8C840"))
        backButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48))
        constraints.append(backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36))
        constraints.append(backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12))
        constraints.append(backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor))
    }
    
    private func initLightButton() {
        view.addSubview(lightButton)
        lightButton.setImage(withName: "Lamp", tintColor: UIColor(hexString: "#585858"))
        lightButton.setBackgroundColor(UIColor(hexString: "#F4BF71"))
        lightButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        lightButton.layer.cornerRadius = 20
        lightButton.setTitle("亮度/色溫", tintColor: UIColor(hexString: "#585858"))
        lightButton.setShadow(color: UIColor(hexString: "#F4BF71"), blur: 10)
        
        lightButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(lightButton.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 48))
        constraints.append(lightButton.leadingAnchor.constraint(equalTo: backButton.leadingAnchor))
        constraints.append(lightButton.heightAnchor.constraint(equalToConstant: 48))
        constraints.append(lightButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4))
    }
    
    private func initFanButton() {
        view.addSubview(fanButton)
        fanButton.setImage(withName: "Fan", tintColor: UIColor(hexString: "#585858"))
        fanButton.layer.cornerRadius = 20
        fanButton.setTitle("風扇", tintColor: UIColor(hexString: "#585858"))
        fanButton.setShadow(color: UIColor(hexString: "#00000020"), blur: 10)
        
        fanButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(fanButton.topAnchor.constraint(equalTo: lightButton.topAnchor))
        constraints.append(fanButton.leadingAnchor.constraint(equalTo: lightButton.trailingAnchor, constant: 24))
        constraints.append(fanButton.heightAnchor.constraint(equalToConstant: 48))
        constraints.append(fanButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4))
    }
    
    private func initOnOffButton() {
        view.addSubview(onOffButton)
        onOffButton.layer.cornerRadius = 28
        onOffButton.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
        
        onOffButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        onOffButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(onOffButton.topAnchor.constraint(equalTo: lightButton.bottomAnchor, constant: 48))
        constraints.append(onOffButton.leadingAnchor.constraint(equalTo: lightButton.leadingAnchor))
        constraints.append(onOffButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2))
        constraints.append(onOffButton.heightAnchor.constraint(equalTo: onOffButton.widthAnchor, multiplier: 1.3))
    }
    
    private func initUVCButton() {
        view.addSubview(uvcButton)
        uvcButton.layer.cornerRadius = 28
        uvcButton.setShadow(color: UIColor(hexString: "#00000020"), blur: 5)
        
        uvcButton.addTarget(self, action: #selector(onClick), for: .touchUpInside)
        
        uvcButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(uvcButton.topAnchor.constraint(equalTo: onOffButton.topAnchor))
        constraints.append(uvcButton.leadingAnchor.constraint(equalTo: onOffButton.trailingAnchor, constant: 24))
        constraints.append(uvcButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2))
        constraints.append(uvcButton.heightAnchor.constraint(equalTo: uvcButton.widthAnchor, multiplier: 1.3))
    }
}

//MARK: Update Views
extension CustomButtonViewController {
    private func updateViews() {}
}
