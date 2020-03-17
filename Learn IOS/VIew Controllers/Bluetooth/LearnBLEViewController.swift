//
//  LearnBLEViewController.swift
//  Learn IOS
//  學習如何操作BLE，目標：搜尋 連線 斷線 Read/Write
//  Created by Kevin Le on 2020/3/14.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class LearnBLEViewController: UIViewController {

    @IBOutlet weak var commandTextField: UITextField!
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var bottomSheetArea: UIView!
    private var bottomSheet: ScanBleBottomSheetViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBottomSheetView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let afterHeight = bottomSheet.getPartialViewHeight()// - bottomSheet.getBottomSafeHeight()
        bottomSheetArea.frame = CGRect(x: 0, y: self.view.frame.height - afterHeight, width: bottomSheetArea.frame.width, height: afterHeight)
    }
    
    func addBottomSheetView() {
        bottomSheet = ScanBleBottomSheetViewController()
        
        self.addChild(bottomSheet)
        self.view.addSubview(bottomSheet.view)
        bottomSheet.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheet.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }

    @IBAction func sendCommand(_ sender: Any) {
        let command = commandTextField.text
        responseTextView.text += "->\(command ?? "null")\n"
        responseTextView.scrollRangeToVisible(NSMakeRange(responseTextView.text.count - 1, 0))
    }
}
