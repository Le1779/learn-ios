//
//  SceneSwitchLight.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/21.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import Foundation

class SceneSwitchLight: Light {
    
    var listener: SceneSwitchLightListener?
    
    enum SendCommand: String {
        case POWER_ON = "key 80"
        case NIGHT_LIGHT_POWER_ON = "key 40"
        case LED = "led "
        case COLOR_TEMPERATURE = "ctemp "
    }
    
    enum GetCommandRegex: String {
        case POWER_ON = "PowerOn"
        case POWER_OFF = "PowerOff"
        case NIGHT_LIGHT_POWER_ON = "NightOn"
        case NIGHT_LIGHT_POWER_OFF = "NightOf"
        case LED = "led:.*"
        case COLOR_TEMPERATURE = "ctemp:.*"
        case TIMER = "time:.*"
    }
    
    func setLightListener(listener: LightListener){
        self.listener = listener as? SceneSwitchLightListener
    }
    
    func analysisResponse(response: String) {
        let responses = response.replacingOccurrences(of: ">", with: "").components(separatedBy: "\r\n")
        for command in responses {
            //print("analysisResponse: " + command)
            if isHandle(command: command, target: GetCommandRegex.POWER_ON) {
                listener?.powerOn()
            } else if isHandle(command: command, target: GetCommandRegex.POWER_OFF) {
                listener?.powerOff()
            } else if isHandle(command: command, target: GetCommandRegex.NIGHT_LIGHT_POWER_ON) {
                listener?.nightLightOn()
            } else if isHandle(command: command, target: GetCommandRegex.NIGHT_LIGHT_POWER_OFF) {
                listener?.nightLightOff()
            } else if isHandle(command: command, target: GetCommandRegex.LED) {
                let bright = Int(command.suffix(2), radix: 16)
                listener?.led(bright: bright ?? 0)
            } else if isHandle(command: command, target: GetCommandRegex.COLOR_TEMPERATURE) {
                let colorTemperature = Int(command.suffix(2), radix: 16)
                listener?.colorTemperature(colorTemperature: colorTemperature ?? 0)
            } else if isHandle(command: command, target: GetCommandRegex.TIMER) {
                listener?.timer(timer: 0)
            }
            
        }
        
    }
    
    func isHandle(command: String, target: GetCommandRegex) -> Bool{
        return command.range(of: target.rawValue, options: [.regularExpression]) != nil
    }
    
}

protocol SceneSwitchLightListener: LightListener {
    func powerOn()
    func powerOff()
    func nightLightOn()
    func nightLightOff()
    func led(bright: Int)
    func colorTemperature(colorTemperature: Int)
    func timer(timer: Int)
}
