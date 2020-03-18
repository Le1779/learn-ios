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
    
    private var deviceListeners = [DeviceListener]()
    
    enum State {
        case connected
        case disconnect
        case connectFail
    }
    
    private override init() {
        super.init()
    }
    
    public func setPeripheral(peripheral: CBPeripheral){
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: WRITE_SERVICE_UUID), CBUUID(string: READ_SERVICE_UUID)])
        self.peripheral = peripheral
    }
    
    public func removePeripheral(){
        peripheral = nil
        notifyStatusChange(state: State.disconnect)
    }
    
    public func isConnected() -> Bool {
        return peripheral != nil
    }
    
    public func addDeviceListener(listener: DeviceListener) {
        if let index = deviceListeners.firstIndex(where: {$0 === listener}) {
            deviceListeners.remove(at: index)
        }
        
        deviceListeners.append(listener)
    }
    
    private func notifyStatusChange(state: BleDeviceManager.State){
        for listener in deviceListeners {
            listener.statusChange(state: state)
        }
    }
}

extension BleDeviceManager:CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        for service: CBService in peripheral.services! {
            print("didDiscoverServices：\(service)")
            if service.uuid == CBUUID(string: WRITE_SERVICE_UUID) {
                peripheral.discoverCharacteristics([CBUUID(string: WRITE_CHARACTERISTICS_UUID)], for: service)
            } else {
                peripheral.discoverCharacteristics([CBUUID(string: READ_CHARACTERISTICS_UUID)], for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic: CBCharacteristic in service.characteristics! {
            print("didDiscoverCharacteristicsFor：\(characteristic)")
        }
        notifyStatusChange(state: State.connected)
    }
    
     func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
         
     }
    
     func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
         
     }
}

protocol DeviceListener: NSObjectProtocol {
    
    func getTag() -> String
    
    /**
     連線狀態改變
     */
    func statusChange(state: BleDeviceManager.State)
}
