//
//  RGBLightViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/23.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class RGBLightViewController: UIViewController {

    @IBOutlet weak var powerSwitch: UISwitch!
    @IBOutlet weak var nightLithgPowerSwitch: UISwitch!
    @IBOutlet weak var brightSlider: UISlider!
    @IBOutlet weak var colorTemperatureSlider: UISlider!
    @IBOutlet weak var commandTextView: UITextView!
    @IBOutlet weak var bottomSheetArea: UIView!
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    private var bottomSheet: ScanBleBottomSheetViewController!
    private var light: SceneSwitchLight?
    private var preSendTime: Double = NSDate().timeIntervalSince1970 * 1000
    private var needGetBrightAndColorTemperatureFromDevice :Bool = false
    
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
        sendCommand(command: SceneSwitchLight.SendCommand.POWER_ON.rawValue)
    }
    
    @IBAction func onNightLIghtPowerChange(_ sender: Any) {
        sendCommand(command: SceneSwitchLight.SendCommand.NIGHT_LIGHT_POWER_ON.rawValue)
    }
    
    @IBAction func onBrightChange(_ sender: Any) {
        let bright = String(lround(Double(brightSlider.value*100)))
        sendCommand(command: SceneSwitchLight.SendCommand.LED.rawValue + bright)
    }
    
    @IBAction func onColorTemperatureChange(_ sender: Any) {
        let colorTemperature = String(lround(Double(colorTemperatureSlider.value*100)))
        sendCommand(command: SceneSwitchLight.SendCommand.COLOR_TEMPERATURE.rawValue + colorTemperature)
    }
    
    @IBAction func redChange(_ sender: Any) {
        sendRgbCommand()
    }
    
    @IBAction func greenChange(_ sender: Any) {
        sendRgbCommand()
    }
    
    @IBAction func blueChange(_ sender: Any) {
        sendRgbCommand()
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
        brightSlider.isEnabled = true
        colorTemperatureSlider.isEnabled = true
        redSlider.isEnabled = true
        greenSlider.isEnabled = true
        blueSlider.isEnabled = true
        commandTextView.backgroundColor = UIColor.init(displayP3Red: 24/255, green: 29/255, blue: 45/255, alpha: 1)
    }
    
    func disableAllView() {
        powerSwitch.isOn = false
        powerSwitch.isEnabled = false
        nightLithgPowerSwitch.isOn = false
        nightLithgPowerSwitch.isEnabled = false
        brightSlider.isEnabled = false
        redSlider.isEnabled = false
        greenSlider.isEnabled = false
        blueSlider.isEnabled = false
        colorTemperatureSlider.isEnabled = false
        commandTextView.backgroundColor = UIColor.init(displayP3Red: 24/255, green: 29/255, blue: 45/255, alpha: 0.8)
    }
    
    func addCommand(command: String) {
        commandTextView.text += command + "\n"
        commandTextView.scrollRangeToVisible(NSMakeRange(commandTextView.text.count - 1, 0))
    }
    
    func sendCommand(command: String) {
        let currentTime = NSDate().timeIntervalSince1970 * 1000
        if(currentTime - preSendTime < 200){
            return
        }
        
        preSendTime = NSDate().timeIntervalSince1970 * 1000
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

    func sendRgbCommand(){
        let red = String(lround(Double(redSlider.value*255)))
        let green = String(lround(Double(greenSlider.value*255)))
        let blue = String(lround(Double(blueSlider.value*255)))
        let rgbCommand = "colorR \(red)\r\ncolorG \(green)\r\ncolorB \(blue)"
        
        sendCommand(command: rgbCommand)
    }
}

extension RGBLightViewController: DeviceListener{
    
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
            self.light?.analysisResponse(response: response)
        }
    }
}

extension RGBLightViewController: SceneSwitchLightListener {
    
    func powerOn() {
        print("Power On")
        self.addCommand(command: "Power On")
        self.powerSwitch.isOn = true
        needGetBrightAndColorTemperatureFromDevice = true
    }
    
    func powerOff() {
        print("Power Off")
        self.addCommand(command: "Power Off")
        self.powerSwitch.isOn = false
        needGetBrightAndColorTemperatureFromDevice = true
    }
    
    func nightLightOn() {
        print("Night Light On")
        self.addCommand(command: "Night Light On")
        self.nightLithgPowerSwitch.isOn = true
        needGetBrightAndColorTemperatureFromDevice = true
    }
    
    func nightLightOff() {
        print("Night Light Off")
        self.addCommand(command: "Night Light Off")
        self.nightLithgPowerSwitch.isOn = false
        needGetBrightAndColorTemperatureFromDevice = true
    }
    
    func led(bright: Int) {
        if !needGetBrightAndColorTemperatureFromDevice {
            return
        }
        
        print("LED: \(bright)")
        self.addCommand(command: "LED: \(bright)")
        brightSlider.value = Float(bright)/255
    }
    
    func colorTemperature(colorTemperature: Int) {
        if !needGetBrightAndColorTemperatureFromDevice {
            return
        }
        
        print("Color Temperature: \(colorTemperature)")
        self.addCommand(command: "Color Temperature: \(colorTemperature)")
        colorTemperatureSlider.value = Float(colorTemperature)/255
        needGetBrightAndColorTemperatureFromDevice = false
    }
    
    func timer(timer: Int) {
        print("Timer: \(timer)")
        self.addCommand(command: "Timer: \(timer)")
        self.enableAllView()
    }
    
    
}
