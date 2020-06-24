//
//  ColorPicker.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/6/23.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class ColorPicker: UITableViewController {
    
    private var colorPickerListeners = [ColorPickerListener]()
    private var rgbItem: [UIColor] = []
    private var cells: [ColorPickerCell] = []
    private var color: String = "red"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ColorPickerCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        self.view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        self.view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func setColor(color: String) {
        self.color = color
        initColors()
    }
    
    public func addColorPickerListener(listener: ColorPickerListener) {
        if let index = colorPickerListeners.firstIndex(where: {$0 === listener}) {
            colorPickerListeners.remove(at: index)
        }
        
        colorPickerListeners.append(listener)
    }
    
    private func notifyColorSelect(color: UIColor){
        for listener in colorPickerListeners {
            listener.select(color: color)
        }
    }
    
    private func notifyColorSelectR(color: UIColor){
        for listener in colorPickerListeners {
            listener.selectR(color: color)
        }
    }
    
    private func notifyColorSelectG(color: UIColor){
        for listener in colorPickerListeners {
            listener.selectG(color: color)
        }
    }
    
    private func notifyColorSelectB(color: UIColor){
        for listener in colorPickerListeners {
            listener.selectB(color: color)
        }
    }
    
    private func initColors(){
        let gap = 20
        let rate = 255/gap
        for i in 1...gap {
            switch color {
                case "red":
                    self.rgbItem.append(UIColor(red: CGFloat(255 - rate*i)/255, green: 0, blue: 0, alpha: 1))
                    break
                case "green":
                    self.rgbItem.append(UIColor(red: 0, green: CGFloat(255 - rate*i)/255, blue: 0, alpha: 1))
                    break
                case "blue":
                    self.rgbItem.append(UIColor(red: 0, green: 0, blue: CGFloat(255 - rate*i)/255, alpha: 1))
                    break
                default:
                    self.rgbItem.append(UIColor(red: CGFloat(255 - rate*i)/255, green: 0, blue: 0, alpha: 1))
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rgbItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! ColorPickerCell
        cell.setColor(color: rgbItem[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height// + tableView.frame.height/6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        switch color {
            case "red":
                notifyColorSelectR(color: rgbItem[indexPath.row])
                break
            case "green":
                notifyColorSelectG(color: rgbItem[indexPath.row])
                break
            case "blue":
                notifyColorSelectB(color: rgbItem[indexPath.row])
                break
            default:
                notifyColorSelectR(color: rgbItem[indexPath.row])
        }
    }
    
    // MARK: - Cell
    class ColorPickerCell: UITableViewCell {
        
        var isAddSubview: Bool = false
        var viewWidth: CGFloat = 0.0
        var margin: CGFloat = 0.0
        var viewFrame: CGRect = CGRect()
        var cornerRadius: CGFloat = 0.0
        var colorView: UIView
        var selectedView: UIView
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            colorView = UIView()
            colorView.clipsToBounds = true
            
            selectedView = UIView()
            selectedView.clipsToBounds = true
            selectedView.backgroundColor = .darkGray
            
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.addSubview(colorView)
            //initSelectedView()
            
            //self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            self.backgroundColor = .clear
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSubviews() {
            viewWidth = self.frame.height
            viewFrame = CGRect(x: margin, y: margin, width: viewWidth, height: viewWidth)
            cornerRadius = 0
            
            resizeColorView()
            //resizeSelectedView()
        }
        
        public func setColor(color: UIColor) {
            colorView.backgroundColor = color
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

protocol ColorPickerListener: NSObjectProtocol {
    
    func select(color: UIColor)
    func selectR(color: UIColor)
    func selectG(color: UIColor)
    func selectB(color: UIColor)
}
