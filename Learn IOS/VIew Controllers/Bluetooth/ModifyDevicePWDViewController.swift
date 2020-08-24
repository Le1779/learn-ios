//
//  ModifyDevicePWDViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/7/27.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class ModifyDevicePWDViewController: UIViewController {
    
    @IBOutlet weak var connectPasswordTextField: UITextField!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var settingPasswordButton: UIButton!
    @IBOutlet weak var bottomSheetArea: UIView!
    private var bottomSheet: ScanBleBottomSheetViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        disableAllView()
        addBottomSheetView()
        BleDeviceManager.instance.addDeviceListener(listener: self)
        connectPasswordTextField.delegate = self
        oldPasswordTextField.delegate = self
        newPasswordTextField.delegate = self
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
    
    @IBAction func disconnect(_ sender: Any) {
    }
    
    @IBAction func settingNewPassword(_ sender: Any) {
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
    
    func enableAllView() {
        //commandTextField.isUserInteractionEnabled = true
    }
    
    func disableAllView() {
        //commandTextField.isUserInteractionEnabled = false
    }

}

extension ModifyDevicePWDViewController: DeviceListener{
    
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
            //self.addText(text: "GET: \(response)\n")
        }
    }
}

extension ModifyDevicePWDViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
    }
}
