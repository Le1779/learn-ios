//
//  BleDeviceManager.swift
//  Learn IOS
//  BLE裝置操作類別
//  Created by Kevin Le on 2020/3/18.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import Foundation
import CoreBluetooth

class BleDeviceManager: NSObject {
    
    static let instance = BleDeviceManager()
    var peripheral: CBPeripheral?
    
    let WRITE_SERVICE_UUID: String = "FFE5"
    let READ_SERVICE_UUID: String = "FFE0"
    let WRITE_CHARACTERISTICS_UUID: String = "FFE9"
    let READ_CHARACTERISTICS_UUID: String = "FFE4"
    
    let SERVICE_UUID: String = "0000ffe0-0000-1000-8000-00805f9b34fb"
    
    private override init() {
        super.init()
    }
    
    public func setPeripheral(peripheral: CBPeripheral){
        peripheral.delegate = self
        peripheral.discoverServices(nil)
        //peripheral.discoverServices([CBUUID(string: WRITE_SERVICE_UUID), CBUUID(string: READ_SERVICE_UUID)])
        self.peripheral = peripheral
    }
}

extension BleDeviceManager:CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        for service: CBService in peripheral.services! {
            print("didDiscoverServices：\(service)")
            //peripheral.discoverCharacteristics([CBUUID(string: WRITE_SERVICE_UUID), CBUUID(string: READ_SERVICE_UUID)], for: service)
        }
    }
}
