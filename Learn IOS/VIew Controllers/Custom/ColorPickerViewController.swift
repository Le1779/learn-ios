//
//  ColorPickerViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/6/23.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class ColorPickerViewController: UIViewController {

    let colorView: UIView = UIView()
    var shadowLayer: ShadowView?
    let redPicker = ColorPicker()
    let greenPicker = ColorPicker()
    let bluePicker = ColorPicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.addChild(redPicker)
        self.view.addSubview(redPicker.view)
        redPicker.didMove(toParent: self)
        redPicker.addColorPickerListener(listener: self)
        redPicker.setColor(color: "red")
        
        self.addChild(greenPicker)
        self.view.addSubview(greenPicker.view)
        greenPicker.didMove(toParent: self)
        greenPicker.addColorPickerListener(listener: self)
        greenPicker.setColor(color: "green")
        
        self.addChild(bluePicker)
        self.view.addSubview(bluePicker.view)
        bluePicker.didMove(toParent: self)
        bluePicker.addColorPickerListener(listener: self)
        bluePicker.setColor(color: "blue")
        
        colorView.frame = CGRect(x: 48, y: 500, width: self.view.frame.width - 96, height: self.view.frame.height/5)
        colorView.layer.cornerRadius = colorView.frame.height/20
        colorView.clipsToBounds = true
        colorView.backgroundColor = .black
        
        shadowLayer = ShadowView(frame: colorView.frame,
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        redPicker.view.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 100)
        greenPicker.view.frame = CGRect(x: 0, y: 200, width: self.view.frame.width, height: 100)
        bluePicker.view.frame = CGRect(x: 0, y: 300, width: self.view.frame.width, height: 100)
    }
}

extension ColorPickerViewController: ColorPickerListener {
    func selectR(color: UIColor) {
        colorView.backgroundColor = UIColor(red: color.coreImageColor.red, green: (colorView.backgroundColor?.coreImageColor.green)!, blue: (colorView.backgroundColor?.coreImageColor.blue)!, alpha: 1)
    }
    
    func selectG(color: UIColor) {
        colorView.backgroundColor = UIColor(red: (colorView.backgroundColor?.coreImageColor.red)!, green: color.coreImageColor.green, blue: (colorView.backgroundColor?.coreImageColor.blue)!, alpha: 1)
    }
    
    func selectB(color: UIColor) {
        colorView.backgroundColor = UIColor(red: (colorView.backgroundColor?.coreImageColor.red)!, green: (colorView.backgroundColor?.coreImageColor.green)!, blue: color.coreImageColor.blue, alpha: 1)
    }
    
    
    func select(color: UIColor) {
        colorView.backgroundColor = color
        shadowLayer?.setShadowColor(shadowColor: color)
    }
    
}

extension UIColor {
    var coreImageColor: CIColor {
        return CIColor(color: self)
    }
}
