//
//  LearnBottomSheetViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/13.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class LearnBottomSheetViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
