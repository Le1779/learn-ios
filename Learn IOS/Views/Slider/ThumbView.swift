//
//  ThumbView.swift
//  Learn IOS
//
//  Created by Kevin Le on 2021/8/13.
//  Copyright © 2021 Kevin Le. All rights reserved.
//

import UIKit

class ThumbView: UIView {
    
    private var width: CGFloat
    
    public init(width: CGFloat){
        self.width = width
        super.init(frame: CGRect(x: 0, y: 0, width: width, height: width))
        backgroundColor = .white
        layer.cornerRadius = width/2
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = width/2
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
