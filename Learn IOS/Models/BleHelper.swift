//
//  BleHelper.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/16.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import Foundation
import CoreBluetooth

class BleHelper: NSObject{
    
    private var centralManager: CBCentralManager?
    
    static let instance = BleHelper()
    
    private var discoveredDevices: [CBPeripheral] = []
    
    private var scanListeners = [ScanListener]()
    
    private override init() {
        super.init()
        print("init BleHelper")
        centralManager = CBCentralManager.init(delegate: self, queue: .main)
    }
    
    public func connect(peripheral: CBPeripheral){
        centralManager?.connect(peripheral, options: nil)
    }
    
    public func disConnect(peripheral:CBPeripheral){
        centralManager?.cancelPeripheralConnection(peripheral)
    }
    
    public func startScan(){
        print("Start Scan")
        discoveredDevices.removeAll(keepingCapacity: false)
        DispatchQueue.global().async {
            sleep(UInt32(10))
            self.stopScan()
        }
        
        let options = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        centralManager?.scanForPeripherals(withServices: nil, options: options)
    }
    
    public func stopScan(){
        print("Stop Scan")
        centralManager?.stopScan()
    }
    
    public func addScanListener(listener: ScanListener) {
        if let index = scanListeners.firstIndex(where: {$0 === listener}) {
            scanListeners.remove(at: index)
        }
        
        scanListeners.append(listener)
    }
    
    private func notifyFindNewDevice(peripheral: CBPeripheral, rssi: NSNumber){
        for listener in scanListeners {
            let name = peripheral.name ?? "-"
            let mac = peripheral.identifier.uuidString
            
            listener.findNewDevice?(device: BleDevice(name: name, mac: mac, rssi: rssi))
        }
    }
    
    private func notifyUpdateRssi(peripheral: CBPeripheral, rssi: NSNumber){
        for listener in scanListeners {
            let mac = peripheral.identifier.uuidString
            listener.updateRssi?(mac: mac, rssi: rssi)
        }
    }
}

extension BleHelper: CBCentralManagerDelegate{
    func centralManagerDidUpdateState(_ central: CBCentralManager){
        switch central.state {
        case .unknown:
            print("CBCentralManagerStateUnknown")
        case .resetting:
            print("CBCentralManagerStateResetting")
        case .unsupported:
            print("CBCentralManagerStateUnsupported")
        case .unauthorized:
            print("CBCentralManagerStateUnauthorized")
        case .poweredOff:
            print("CBCentralManagerStatePoweredOff")
        case .poweredOn:
            print("CBCentralManagerStatePoweredOn")

        @unknown default:
            print("CBCentralManagerStateUnknown")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        
        if(!discoveredDevices.contains(peripheral)) {
            discoveredDevices.append(peripheral)
            notifyFindNewDevice(peripheral: peripheral, rssi: RSSI)
        }else {
            notifyUpdateRssi(peripheral: peripheral, rssi: RSSI)
        }
    }
}

/**
 搜尋的監聽者
 */
@objc protocol ScanListener: NSObjectProtocol{
    
    func getTag() -> String
    
    /**
     找到新的裝置
     */
    @objc optional func findNewDevice(device: BleDevice)
    
    /**
     更新裝置的RSSI
     */
    @objc optional func updateRssi(mac: String, rssi:NSNumber)
}
