//
//  RGBSelecterViewController.swift
//  Learn IOS
//  控制顏色選擇元件
//  Created by Kevin Le on 2020/3/29.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class RGBSelectorViewController: UIViewController {
    
    let colorView: UIView = UIView()
    var shadowLayer: ShadowLayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let smRgbSelect = RGBSelector()
        self.addChild(smRgbSelect)
        self.view.addSubview(smRgbSelect.view)
        smRgbSelect.didMove(toParent: self)
        smRgbSelect.view.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 100)
        smRgbSelect.addColorSelectListener(listener: self)
        
        let mdRgbSelect = RGBSelector()
        self.addChild(mdRgbSelect)
        self.view.addSubview(mdRgbSelect.view)
        mdRgbSelect.didMove(toParent: self)
        mdRgbSelect.view.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 120)
        mdRgbSelect.addColorSelectListener(listener: self)

        let rgbSelect = RGBSelector()
        self.addChild(rgbSelect)
        self.view.addSubview(rgbSelect.view)
        rgbSelect.didMove(toParent: self)
        rgbSelect.view.frame = CGRect(x: 0, y: 300, width: self.view.frame.width, height: 150)
        rgbSelect.addColorSelectListener(listener: self)
        
        colorView.frame = CGRect(x: 48, y: 500, width: self.view.frame.width - 96, height: self.view.frame.height/5)
        colorView.layer.cornerRadius = colorView.frame.height/20
        colorView.clipsToBounds = true
        colorView.backgroundColor = .black
        
        shadowLayer = ShadowLayer(frame: colorView.frame,
                                  bounds: colorView.bounds,
                                  cornerRadius: colorView.layer.cornerRadius,
                                  shadowRadius: colorView.frame.width/5,
                                  shadowOpacity: 1,
                                  shadowOffset: CGSize(width: 0.0, height: 0.0),
                                  shadowColor: .black
        )
        
        self.view.addSubview(shadowLayer!)
        self.view.addSubview(colorView)
    }

}

extension RGBSelectorViewController: ColorSelectListener {
    
    func select(color: UIColor) {
        colorView.backgroundColor = color
        shadowLayer?.setShadowColor(shadowColor: color)
    }
    
}
