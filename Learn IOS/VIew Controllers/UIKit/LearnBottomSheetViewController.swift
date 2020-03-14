//
//  LearnBottomSheetViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/13.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class LearnBottomSheetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomSheetView()
    }
    
    func addBottomSheetView() {
        let bottomSheetVC = BottomSheetViewController()
        
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }

}
