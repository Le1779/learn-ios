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
    
    enum State {
        case connected
        case connecting
        case disconnect
        case connectFail
    }
    
    static let instance = BleHelper()
    private var centralManager: CBCentralManager?
    private var discoveredDevices: [CBPeripheral] = []
    private var scanListeners = [ScanListener]()
    private var deviceListeners = [DeviceListener]()
    
    private override init() {
        super.init()
        print("init BleHelper")
        centralManager = CBCentralManager.init(delegate: self, queue: .main)
    }
    
    public func connect(mac: String){
        let peripheral = findPeripheralByMac(mac: mac)
        
        if peripheral != nil {
            notifyStatusChange(state: State.connecting)
            centralManager?.connect(peripheral!, options: nil)
        }
    }
    
    public func disConnect(mac: String){
        let peripheral = findPeripheralByMac(mac: mac)
        
        if peripheral != nil {
            centralManager?.cancelPeripheralConnection(peripheral!)
        }
    }
    
    public func startScan(){
        if self.centralManager!.isScanning {
            return
        }
        
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
        if self.centralManager!.isScanning {
            print("Stop Scan")
            notifyIsStopScan()
            centralManager?.stopScan()
        }
    }
    
    public func addScanListener(listener: ScanListener) {
        if let index = scanListeners.firstIndex(where: {$0 === listener}) {
            scanListeners.remove(at: index)
        }
        
        scanListeners.append(listener)
    }
    
    public func addDeviceListener(listener: DeviceListener) {
        if let index = deviceListeners.firstIndex(where: {$0 === listener}) {
            deviceListeners.remove(at: index)
        }
        
        deviceListeners.append(listener)
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
    
    private func notifyIsStopScan(){
        for listener in scanListeners {
            listener.isStopScan?()
        }
    }
    
    private func notifyStatusChange(state: BleHelper.State){
        for listener in deviceListeners {
            listener.statusChange(state: state)
        }
    }
    
    private func findPeripheralByMac(mac: String) -> CBPeripheral? {
        return discoveredDevices.first(where: {$0.identifier.uuidString == mac})
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
        
        if peripheral.name == nil || !peripheral.name!.contains("Tv500u"){
            return
        }
        
        if(!discoveredDevices.contains(peripheral)) {
            discoveredDevices.append(peripheral)
            notifyFindNewDevice(peripheral: peripheral, rssi: RSSI)
        }else {
            notifyUpdateRssi(peripheral: peripheral, rssi: RSSI)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("連線成功 \(peripheral.identifier)")
        
        BleDeviceManager.instance.setPeripheral(peripheral: peripheral)
        
        notifyStatusChange(state: State.connected)
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("連線失敗")
        notifyStatusChange(state: State.connectFail)
    }
    //斷開連線
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("斷開連線")
        notifyStatusChange(state: State.disconnect)
    }
}

/**
 搜尋的監聽者
 */
@objc protocol ScanListener: NSObjectProtocol {
    
    func getTag() -> String
    
    /**
     找到新的裝置
     */
    @objc optional func findNewDevice(device: BleDevice)
    
    /**
     更新裝置的RSSI
     */
    @objc optional func updateRssi(mac: String, rssi:NSNumber)
    
    /**
     已經停止掃描
     */
    @objc optional func isStopScan()
}

/**
 連線裝置的監聽者
 */
protocol DeviceListener: NSObjectProtocol {
    
    func getTag() -> String
    
    /**
     連線狀態改變
     */
    func statusChange(state: BleHelper.State)
}
