//
//  DiscoveredPeripheral.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/16.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import CoreBluetooth

class DiscoveredPeripheral {
    var peripheral: CBPeripheral
    var rssi: NSNumber
    
    init(peripheral: CBPeripheral, rssi: NSNumber) {
        self.peripheral = peripheral
        self.rssi = rssi
    }
}
