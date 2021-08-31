//
//  EmptyCollectionView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/30.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class EmptyCollectionView: UIView {
    
    private let dashedBorder = CAShapeLayer()
    private let icon = UIImageView()
    private let hintLabel = UILabel()
    
    private var subviewConstraints = [NSLayoutConstraint]()
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        setupDashedBorder()
        setupIcon()
        setupHintLabel()
        NSLayoutConstraint.activate(subviewConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashedBorder.frame = self.bounds
        dashedBorder.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 20).cgPath
    }
    
    private func setupDashedBorder() {
        dashedBorder.fillColor = nil
        dashedBorder.strokeColor = UIColor(hexString: "#E8E8E8").cgColor;
        dashedBorder.lineDashPattern = [10, 10]
        dashedBorder.lineWidth = 5
        dashedBorder.frame = self.bounds
        dashedBorder.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 20).cgPath
        self.layer.addSublayer(dashedBorder)
    }
    
    private func setupIcon() {
        addSubview(icon)
        icon.image = UIImage(named: "Lamp")!.withTintColor(UIColor(hexString: "#E8E8E8"))
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        subviewConstraints.append(icon.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        subviewConstraints.append(icon.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        subviewConstraints.append(icon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5))
        subviewConstraints.append(icon.heightAnchor.constraint(equalTo: icon.widthAnchor))
    }
    
    private func setupHintLabel() {
        addSubview(hintLabel)
        hintLabel.numberOfLines = 0
        hintLabel.textAlignment = .center
        hintLabel.font = .boldSystemFont(ofSize: 20)
        hintLabel.textColor = UIColor(hexString: "#787878")
        hintLabel.text = "Collection is empty."
        
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        subviewConstraints.append(hintLabel.widthAnchor.constraint(equalTo: self.widthAnchor))
        subviewConstraints.append(hintLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        subviewConstraints.append(hintLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4))
        subviewConstraints.append(hintLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor))
    }
}
