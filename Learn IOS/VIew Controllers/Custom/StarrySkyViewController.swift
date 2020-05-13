//
//  StarrySkyViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/4/21.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class StarrySkyViewController: UIViewController {
    
    let starrySkyView: StarrySkyView = StarrySkyView();

    override func viewDidLoad() {
        super.viewDidLoad()

        let screenWidth = self.view.frame.width
        let screenHeight = self.view.frame.height
        print("viewDidLoad height: \(screenHeight), width: \(screenWidth)")
        
        starrySkyView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        self.view.addSubview(starrySkyView)
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        starrySkyView.drawStars()
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
