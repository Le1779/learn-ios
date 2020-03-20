//
//  BleDevice.swift
//  Learn IOS
//  藍芽裝置的傳遞物件
//  Created by Kevin Le on 2020/3/17.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import Foundation

class BleDevice: NSObject{
    
    var name: String
    var mac: String
    var rssi: NSNumber
    
    init(name: String, mac: String, rssi: NSNumber) {
        self.name = name
        self.mac = mac
        self.rssi = rssi
    }
}
