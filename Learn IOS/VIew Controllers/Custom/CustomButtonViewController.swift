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
    
    private let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateViews()
    }
}

//MARK: Initial Views
extension CustomButtonViewController {
    private func initViews() {
        initBackButton()
        initCustomButton()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initBackButton() {
        view.addSubview(backButton)
        backButton.backgroundColor = UIColor(hexString: "#C8C8C840")
        backButton.setImage(UIImage(named: "ArrowBack")?.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = UIColor(hexString: "#585858")
        
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 48))
        constraints.append(backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36))
        constraints.append(backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.12))
        constraints.append(backButton.heightAnchor.constraint(equalTo: backButton.widthAnchor))
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
    private func updateViews() {
        updateBackButton()
    }
    
    private func updateBackButton() {
        backButton.layer.cornerRadius = backButton.frame.size.width/2
        let edge = backButton.frame.size.width/4
        backButton.imageEdgeInsets = UIEdgeInsets(top: edge, left: edge, bottom: edge, right: edge)
    }
}
