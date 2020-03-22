//
//  SceneSwitchLightViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/21.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class SceneSwitchLightViewController: UIViewController {

    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var nightLithgPowerSwitch: UISwitch!
    @IBOutlet weak var colorTemperatureSlider: UISlider!
    @IBOutlet weak var brightSlider: UISlider!
    @IBOutlet weak var commandTextView: UITextView!
    @IBOutlet weak var bottomSheetArea: UIView!
    private var bottomSheet: ScanBleBottomSheetViewController!
    
    private var light: SceneSwitchLight?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLight()
        disableAllView()
        addBottomSheetView()
        BleDeviceManager.instance.addDeviceListener(listener: self)
        commandTextView.isEditable = false
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
    
    @IBAction func onPowerChange(_ sender: Any) {
    }
    
    @IBAction func onNightLIghtPowerChange(_ sender: Any) {
    }
    
    @IBAction func onBrightChange(_ sender: Any) {
    }
    
    @IBAction func onColorTemperatureChange(_ sender: Any) {
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
        powerSwitch.isEnabled = true
        nightLithgPowerSwitch.isEnabled = true
        colorTemperatureSlider.isEnabled = true
        commandTextView.backgroundColor = UIColor.init(displayP3Red: 24/255, green: 29/255, blue: 45/255, alpha: 1)
    }
    
    func disableAllView() {
        powerSwitch.isOn = false
        powerSwitch.isEnabled = false
        nightLithgPowerSwitch.isOn = false
        nightLithgPowerSwitch.isEnabled = false
        colorTemperatureSlider.isEnabled = false
        commandTextView.backgroundColor = UIColor.init(displayP3Red: 24/255, green: 29/255, blue: 45/255, alpha: 0.8)
    }
    
    func addCommand(command: String) {
        commandTextView.text += command + "\n"
        commandTextView.scrollRangeToVisible(NSMakeRange(commandTextView.text.count - 1, 0))
    }
    
    func sendCommand(command: String) {
        BleDeviceManager.instance.sendData(data: command + "\r\n")
        addCommand(command: "SEND: \(command)")
    }

    func initLight(){
        self.light = SceneSwitchLight()
        self.light?.setLightListener(listener: self)
    }
    
    @IBAction func sendConnectedCommand(_ sender: Any) {
        if !BleDeviceManager.instance.isConnected() {
            return
        }
        
        sendCommand(command: "connected")
    }
}

extension SceneSwitchLightViewController: DeviceListener{
    
    func statusChange(state: BleDeviceManager.State) {
        switch state {
            case BleDeviceManager.State.connected:
                self.sendCommand(command: "connected")
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
            self.addCommand(command: "GET: \(response)")
            self.light?.analysisResponse(response: response)
        }
    }
}

extension SceneSwitchLightViewController: SceneSwitchLightListener {
    
    func powerOn() {
        print("Power On")
        self.addCommand(command: "Power On")
        self.enableAllView()
        self.powerSwitch.isOn = true
    }
    
    func powerOff() {
        print("Power Off")
        self.addCommand(command: "Power Off")
        self.powerSwitch.isOn = false
    }
    
    func nightLightOn() {
        print("Night Light On")
        self.addCommand(command: "Night Light On")
        self.nightLithgPowerSwitch.isOn = true
    }
    
    func nightLightOff() {
        print("Night Light Off")
        self.addCommand(command: "Night Light Off")
        self.nightLithgPowerSwitch.isOn = false
    }
    
    func led(bright: Int) {
        print("LED: \(bright)")
        self.addCommand(command: "LED: \(bright)")
        brightSlider.value = Float(bright)/255
    }
    
    func colorTemperature(colorTemperature: Int) {
        print("Color Temperature: \(colorTemperature)")
        self.addCommand(command: "Color Temperature: \(colorTemperature)")
        colorTemperatureSlider.value = Float(colorTemperature)/255
    }
    
    func timer(timer: Int) {
        print("Timer: \(timer)")
        self.addCommand(command: "Timer: \(timer)")
    }
    
    
}
