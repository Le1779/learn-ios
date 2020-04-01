//
//  RGBTableViewController.swift
//  Learn IOS
//  顏色選擇器
//  Created by Kevin Le on 2020/3/29.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class RGBSelector: UITableViewController {
    
    private var colorSelectListeners = [ColorSelectListener]()
    private var rgbItem: [UIColor] = []
    private var cells: [RGBSelectorCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RGBSelectorCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        self.view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        self.view.backgroundColor = .clear
        initColors()
    }
    
    public func addColorSelectListener(listener: ColorSelectListener) {
        if let index = colorSelectListeners.firstIndex(where: {$0 === listener}) {
            colorSelectListeners.remove(at: index)
        }
        
        colorSelectListeners.append(listener)
    }
    
    private func notifyColorSelect(color: UIColor){
        for listener in colorSelectListeners {
            listener.select(color: color)
        }
    }
    
    private func initColors(){
        let black: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let white: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let red: UIColor = UIColor(red: 232/255, green: 79/255, blue: 114/255, alpha: 1)
        let orangeRed: UIColor = UIColor(red: 230/255, green: 77/255, blue: 67/255, alpha: 1)
        let orange: UIColor = UIColor(red: 238/255, green: 143/255, blue: 68/255, alpha: 1)
        let yellow: UIColor = UIColor(red: 248/255, green: 214/255, blue: 73/255, alpha: 1)
        let yellowGreen: UIColor = UIColor(red: 174/255, green: 214/255, blue: 79/255, alpha: 1)
        let lime: UIColor = UIColor(red: 88/255, green: 189/255, blue: 103/255, alpha: 1)
        let turquoise: UIColor = UIColor(red: 85/255, green: 184/255, blue: 194/255, alpha: 1)
        let dodgerBlue: UIColor = UIColor(red: 61/255, green: 149/255, blue: 216/255, alpha: 1)
        let blue: UIColor = UIColor(red: 66/255, green: 74/255, blue: 167/255, alpha: 1)
        let purple: UIColor = UIColor(red: 93/255, green: 74/255, blue: 188/255, alpha: 1)
        let plum: UIColor = UIColor(red: 160/255, green: 116/255, blue: 188/255, alpha: 1)
        let pink: UIColor = UIColor(red: 238/255, green: 149/255, blue: 199/255, alpha: 1)
        let bisque: UIColor = UIColor(red: 242/255, green: 186/255, blue: 179/255, alpha: 1)
        let wheat: UIColor = UIColor(red: 227/255, green: 206/255, blue: 172/255, alpha: 1)
        let tan: UIColor = UIColor(red: 180/255, green: 146/255, blue: 97/255, alpha: 1)
        let brown: UIColor = UIColor(red: 105/255, green: 79/255, blue: 41/255, alpha: 1)
        let gray: UIColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        self.rgbItem.append(black)
        self.rgbItem.append(white)
        self.rgbItem.append(red)
        self.rgbItem.append(orangeRed)
        self.rgbItem.append(orange)
        self.rgbItem.append(yellow)
        self.rgbItem.append(yellowGreen)
        self.rgbItem.append(lime)
        self.rgbItem.append(turquoise)
        self.rgbItem.append(dodgerBlue)
        self.rgbItem.append(blue)
        self.rgbItem.append(purple)
        self.rgbItem.append(plum)
        self.rgbItem.append(pink)
        self.rgbItem.append(bisque)
        self.rgbItem.append(wheat)
        self.rgbItem.append(tan)
        self.rgbItem.append(brown)
        self.rgbItem.append(gray)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rgbItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RGBSelectorCell
        cell.setColor(color: rgbItem[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height + tableView.frame.height/6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        notifyColorSelect(color: rgbItem[indexPath.row])
    }
    
    // MARK: - Cell
    class RGBSelectorCell: UITableViewCell {
        
        var isAddSubview: Bool = false
        var viewWidth: CGFloat = 0.0
        var margin: CGFloat = 0.0
        var viewFrame: CGRect = CGRect()
        var cornerRadius: CGFloat = 0.0
        var colorView: UIView
        var shadowLayer : ShadowLayer
        var selectedView: UIView
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            colorView = UIView()
            colorView.clipsToBounds = true
            
            shadowLayer = ShadowLayer(frame: colorView.frame,
                                      bounds: colorView.bounds,
                                      shadowOpacity: 0.5,
                                      shadowOffset: CGSize(width: 0.0, height: 0.0)
            )
            
            selectedView = UIView()
            selectedView.clipsToBounds = true
            selectedView.backgroundColor = .darkGray
            
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.addSubview(shadowLayer)
            self.addSubview(colorView)
            initSelectedView()
            
            self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            self.backgroundColor = .clear
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            viewWidth = self.frame.height - self.frame.height/6
            margin = viewWidth/6
            viewFrame = CGRect(x: margin, y: margin, width: viewWidth - margin*2, height: viewWidth - margin*2)
            cornerRadius = viewWidth/2 - margin
            
            resizeColorView()
            resizeShadowLayer()
            resizeSelectedView()
        }
        
        public func setColor(color: UIColor) {
            colorView.backgroundColor = color
            shadowLayer.setShadowColor(shadowColor: color)
        }
        
        private func initSelectedView() {
            self.selectedBackgroundView? = UIView(frame: viewFrame)
            self.selectedBackgroundView?.backgroundColor = .clear
            self.selectedBackgroundView?.addSubview(selectedView)
        }
        
        private func resizeColorView() {
            colorView.frame = viewFrame
            colorView.layer.cornerRadius = cornerRadius
        }
        
        private func resizeShadowLayer() {
            shadowLayer.setFrame(frame: viewFrame)
            shadowLayer.setBounds(bounds: colorView.bounds)
            shadowLayer.setCornerRadius(cornerRadius: cornerRadius)
            shadowLayer.setShadowRadius(shadowRadius: margin/2)
        }
        
        private func resizeSelectedView() {
            self.selectedBackgroundView?.frame = viewFrame
            let borderWidth = margin/2.5
            selectedView.frame = CGRect(x: -borderWidth,
                                        y: -borderWidth,
                                        width: viewWidth - (margin - borderWidth)*2,
                                        height: viewWidth - (margin - borderWidth)*2)
            selectedView.layer.cornerRadius = cornerRadius + borderWidth
        }
    }

}

protocol ColorSelectListener: NSObjectProtocol {
    
    func select(color: UIColor)
}
