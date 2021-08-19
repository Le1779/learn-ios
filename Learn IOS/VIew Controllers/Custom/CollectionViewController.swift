//
//  CollectionViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/19.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    private let backButton = LeButton()
    private var collectionView: UICollectionView!
    
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
extension CollectionViewController {
    private func initViews() {
        initBackButton()
        initCollectionView()
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
    
    private func initCollectionView() {
        collectionView = CenterCollectionView(widthScale: 0.6, heightScale: 0.9)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "collectionViewCell")
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        constraints.append(collectionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 36))
        constraints.append(collectionView.widthAnchor.constraint(equalTo: view.widthAnchor))
        constraints.append(collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6))
        constraints.append(collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
    }
}

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath)
        cell.backgroundColor = .white
        
        cell.layer.cornerRadius = cell.frame.width*0.15
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 10
        
        return cell
    }
}
