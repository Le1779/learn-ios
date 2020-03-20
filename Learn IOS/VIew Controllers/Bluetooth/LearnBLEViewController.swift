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
        disableAllView()
        addBottomSheetView()
        BleDeviceManager.instance.addDeviceListener(listener: self)
        commandTextField.delegate = self
        responseTextView.isEditable = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let afterHeight = bottomSheet.getPartialViewHeight()// - bottomSheet.getBottomSafeHeight()
        bottomSheetArea.frame = CGRect(x: 0, y: self.view.frame.height - afterHeight, width: bottomSheetArea.frame.width, height: afterHeight)
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
        BleHelper.instance.stopScan()
        BleDeviceManager.instance.disconnect()
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
        if !BleDeviceManager.instance.isConnected() {
            addText(text: "尚未連線\n")
            return
        }
        let command = commandTextField.text
        BleDeviceManager.instance.sendData(data: command! + "\r\n")
        addText(text: "SEND: \(command ?? "null")\n")
    }
    
    func enableAllView() {
        commandTextField.isUserInteractionEnabled = true
        responseTextView.backgroundColor = UIColor.init(displayP3Red: 24/255, green: 29/255, blue: 45/255, alpha: 1)
    }
    
    func disableAllView() {
        commandTextField.isUserInteractionEnabled = false
        responseTextView.backgroundColor = UIColor.init(displayP3Red: 24/255, green: 29/255, blue: 45/255, alpha: 0.8)
    }
    
    func addText(text: String) {
        responseTextView.text += text
        responseTextView.scrollRangeToVisible(NSMakeRange(responseTextView.text.count - 1, 0))
    }
}

extension LearnBLEViewController: DeviceListener{
    
    func statusChange(state: BleDeviceManager.State) {
        switch state {
            case BleDeviceManager.State.connected:
                enableAllView()
                break
            case BleDeviceManager.State.disconnect:
                disableAllView()
                break
            default:
                break
        }
    }
    
    func getResponse(response: String) {
        DispatchQueue.main.async{
            self.addText(text: "GET: \(response)\n")
        }
    }
}

extension LearnBLEViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
    }
}
