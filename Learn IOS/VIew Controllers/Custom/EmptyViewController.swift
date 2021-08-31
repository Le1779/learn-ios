//
//  EmptyViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/30.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class EmptyViewController: UIViewController {

    private let backButton = LeButton()
    private let emptyCollectionView = EmptyCollectionView()
    
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
extension EmptyViewController {
    private func initViews() {
        initBackButton()
        initEmptyCollectionView()
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
    
    private func initEmptyCollectionView() {
        self.view.addSubview(emptyCollectionView)
        
        emptyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(emptyCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6))
        constraints.append(emptyCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6))
        constraints.append(emptyCollectionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 48))
        constraints.append(emptyCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor))
    }
}
