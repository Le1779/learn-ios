//
//  RGBTableViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/29.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class RGBSelector: UITableViewController {
    
    let rgbItem: [UIColor] = [.black, .white, .red, .orange, .yellow, .green, .blue, .purple]
    var cells: [RGBSelectorCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RGBSelectorCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        self.view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        self.view.backgroundColor = .clear
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rgbItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !cells.indices.contains(indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RGBSelectorCell
            cell.initView(color: rgbItem[indexPath.row])
            cells.insert(cell, at: indexPath.row)
        }

        return cells[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height + tableView.frame.height/6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    class RGBSelectorCell: UITableViewCell {
        
        var isAddSubview: Bool = false
        var viewWidth: CGFloat = 0.0
        var margin: CGFloat = 0.0
        var viewFrame: CGRect = CGRect()
        var cornerRadius: CGFloat = 0.0
        
        public func initView(color: UIColor) {
            if isAddSubview {
                return
            }
            
            isAddSubview = true
            viewWidth = self.frame.height - self.frame.height/6
            margin = viewWidth/6
            viewFrame = CGRect(x: margin, y: margin, width: viewWidth - margin*2, height: viewWidth - margin*2)
            cornerRadius = viewWidth/2 - margin
            let colorView = UIView(frame: viewFrame)
            colorView.backgroundColor = color
            colorView.layer.cornerRadius = cornerRadius
            colorView.clipsToBounds = true
            
            let shadowLayer = ShadowLayer(frame: colorView.frame,
                                          bounds: colorView.bounds,
                                          cornerRadius: cornerRadius,
                                          shadowRadius: margin/2,
                                          shadowOpacity: 0.5,
                                          shadowOffset: CGSize(width: 0.0, height: 0.0),
                                          shadowColor: color )
            self.addSubview(shadowLayer)
            self.addSubview(colorView)
            
            self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
            self.backgroundColor = .clear
            initSelectedBackgroundView()
            
        }
        
        private func initSelectedBackgroundView() {
            self.selectedBackgroundView? = UIView(frame: viewFrame)
            self.selectedBackgroundView?.backgroundColor = .clear
            
            let borderWidth = margin/2.5
            let selectedView = UIView(frame: CGRect(x: margin-borderWidth,
                                                    y: margin-borderWidth,
                                                    width: viewWidth - (margin - borderWidth)*2,
                                                    height: viewWidth - (margin - borderWidth)*2) )
            selectedView.backgroundColor = .darkGray
            selectedView.layer.cornerRadius = cornerRadius + borderWidth
            selectedView.clipsToBounds = true
            self.selectedBackgroundView?.addSubview(selectedView)
        }
    }

}
