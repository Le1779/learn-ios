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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViews()
    }
    
    @objc func onClick(_ sender:UIButton) {
        UIImpactFeedbackGenerator().impactOccurred()
    }
}

//MARK: Initial Views
extension CustomButtonViewController {
    private func initViews() {
        initBackButton()
        initLightButton()
        initCustomButton()
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
    
    private func initCustomButton() {
        let buttonFrame = CGRect(x: 50, y: 500, width: 100, height: 50)
        let customButton = CustomButton.Builder(frame: buttonFrame)
            .setBackgroundColor(color: .gray)
            .setText(text: "Click me!")
            .setTextColor(color: .white)
            .setCornerRadius(radius: 12.0)
            .setWithShadow(withShadow: true)
            .build()
        
        self.view.addSubview(customButton)
    }
}

//MARK: Update Views
extension CustomButtonViewController {
    private func updateViews() {}
}
