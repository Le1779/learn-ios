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
    private var connectedPeripheral: CBPeripheral?
    private var responseLock: NSLock = NSLock()
    private var sendLock: NSLock = NSLock()
    
    private let WRITE_SERVICE_UUID: String = "FFE5"
    private let NOTIFY_SERVICE_UUID: String = "FFE0"
    private let WRITE_CHARACTERISTICS_UUID: String = "FFE9"
    private let NOTIFY_CHARACTERISTICS_UUID: String = "FFE4"
    
    private var writeCharacteristics: CBCharacteristic?
    private var notifyCharacteristics: CBCharacteristic?
    
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
        peripheral.discoverServices([CBUUID(string: WRITE_SERVICE_UUID), CBUUID(string: NOTIFY_SERVICE_UUID)])
        self.connectedPeripheral = peripheral
    }
    
    public func removePeripheral(){
        connectedPeripheral = nil
        notifyStatusChange(state: State.disconnect)
    }
    
    public func isConnected() -> Bool {
        return connectedPeripheral != nil
    }
    
    public func getDeviceName() -> String {
        return connectedPeripheral?.name ?? ""
    }
    
    public func addDeviceListener(listener: DeviceListener) {
        if let index = deviceListeners.firstIndex(where: {$0 === listener}) {
            deviceListeners.remove(at: index)
        }
        
        deviceListeners.append(listener)
    }
    
    public func sendData(data: String) {
        sendLock.lock()
        connectedPeripheral?.writeValue(data.data(using: .utf8)!, for: writeCharacteristics!, type: .withResponse)
        sendLock.unlock()
    }
    
    public func disconnect(){
        BleHelper.instance.disConnect(mac: connectedPeripheral!.identifier.uuidString)
        notifyStatusChange(state: State.disconnect)
    }
    
    private func notifyStatusChange(state: BleDeviceManager.State){
        for listener in deviceListeners {
            listener.statusChange(state: state)
        }
    }
    
    private func notifyGetResponse(response: String){
        for listener in deviceListeners {
            listener.getResponse(response: response)
        }
    }
}

extension BleDeviceManager:CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("didDiscoverServices")
        for service: CBService in peripheral.services! {
            print("didDiscoverServices：\(service)")
            if service.uuid == CBUUID(string: WRITE_SERVICE_UUID) {
                print("didDiscoverServices：Wuuid - \(service.uuid)")
                peripheral.discoverCharacteristics([CBUUID(string: WRITE_CHARACTERISTICS_UUID)], for: service)
            } else {
                print("didDiscoverServices：Ruuid - \(service.uuid)")
                peripheral.discoverCharacteristics([CBUUID(string: NOTIFY_CHARACTERISTICS_UUID)], for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        for characteristic: CBCharacteristic in service.characteristics! {
            print("didDiscoverCharacteristicsFor：\(characteristic)")
            switch characteristic.uuid {
                case CBUUID(string: WRITE_CHARACTERISTICS_UUID):
                    if characteristic.properties.contains(CBCharacteristicProperties.write){
                        writeCharacteristics = characteristic
                        notifyStatusChange(state: State.connected)
                    } else {
                        disconnect()
                    }
                    break
                case CBUUID(string: NOTIFY_CHARACTERISTICS_UUID):
                    if characteristic.properties.contains(CBCharacteristicProperties.notify){
                        notifyCharacteristics = characteristic
                        connectedPeripheral?.setNotifyValue(true, for: notifyCharacteristics!)
                        notifyStatusChange(state: State.connected)
                    } else {
                        disconnect()
                    }
                    break
                default:
                    disconnect()
            }
        }
    }
    
     func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        self.responseLock.lock()
        
        guard error == nil else {
            print(error!)
            return
        }
        
        let response = String(data: characteristic.value!, encoding: .utf8)!
        self.notifyGetResponse(response: response)
        
        self.responseLock.unlock()
     }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print(error!)
            return
        }
        
        if !characteristic.isNotifying {
            disconnect()
        }
    }
    
     func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        guard error == nil else {
            print(error!)
            return
        }
     }
}

protocol DeviceListener: NSObjectProtocol {
    
    /**
     連線狀態改變
     */
    func statusChange(state: BleDeviceManager.State)
    
    func getResponse(response: String)
}
