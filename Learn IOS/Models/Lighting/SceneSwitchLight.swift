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
    }
    
    enum GetCommand: String {
        case POWER_ON = "PowerOn"
    }
    
    func setLightListener(listener: LightListener){
        self.listener = listener as? SceneSwitchLightListener
    }
    
    func analysisResponse(response: String) {
        let responses = response.replacingOccurrences(of: ">", with: "").components(separatedBy: "\r\n")
        for command in responses {
            print("analysisResponse: " + command)
            if isHandle(command: command, target: "PowerOn") {
                listener?.powerOn()
            } else if isHandle(command: command, target: "NightOf") {
                listener?.nightLightOff()
            } else if isHandle(command: command, target: "led:.*") {
                listener?.led(bright: 0)
            } else if isHandle(command: command, target: "ctemp:.*") {
                listener?.colorTemperature(colorTemperature: 0)
            } else if isHandle(command: command, target: "time:.*") {
                listener?.timer(timer: 0)
            }
            
        }
        
    }
    
    func isHandle(command: String, target: String) -> Bool{
        return command.range(of: target, options: [.regularExpression]) != nil
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
