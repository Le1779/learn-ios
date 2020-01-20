//
//  LearnBLEScanViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/1/18.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit
import CoreBluetooth

class LearnBLEScanViewController: UIViewController {
    
    @IBOutlet weak var scanTableView: UITableView!
    
    //藍牙管理物件
    var manager: CBCentralManager!
    var discoveredPeripherals: [DiscoveredPeripheral] = []
    
    class DiscoveredPeripheral{
        var peripheral: CBPeripheral
        var rssi: NSNumber
        
        init(peripheral: CBPeripheral, rssi: NSNumber) {
            self.peripheral = peripheral
            self.rssi = rssi
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CBCentralManager.init(delegate: self, queue: DispatchQueue.main)
    }

    @IBAction func startScan(_ sender: Any) {
        print("Start Scan")
        let options = [CBCentralManagerScanOptionAllowDuplicatesKey: true]
        manager.scanForPeripherals(withServices: nil, options: options)
    }
}

// MARK: - TableViewController
extension LearnBLEScanViewController :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredPeripherals.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
        }
        
        let peripheral = discoveredPeripherals[indexPath.row]
        
        if peripheral.peripheral.name != nil{
            cell?.textLabel?.text = String.init(format: "Device Name: %@", (peripheral.peripheral.name)!)
        } else{
            cell?.textLabel?.text = "No Name"
        }
        
        cell?.detailTextLabel?.text = peripheral.rssi.stringValue
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(String.init(format: "Select device Name: %@", (discoveredPeripherals[indexPath.row].peripheral.name)!))
    }
}

// MARK: - CBCentralManager
extension LearnBLEScanViewController :CBCentralManagerDelegate{
    /**監聽CentralManager的狀態*/
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
    
    /**掃描到裝置*/
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber){
        
        var isExisted = false
        var existedPeripheral: DiscoveredPeripheral!
        for obtainedPeriphal  in discoveredPeripherals {
            if (obtainedPeriphal.peripheral.identifier == peripheral.identifier){
                isExisted = true
                existedPeripheral = obtainedPeriphal
            }
        }
        
        if !isExisted{
            discoveredPeripherals.append(DiscoveredPeripheral(peripheral: peripheral, rssi: RSSI))
        } else{
            existedPeripheral.rssi = RSSI
        }
        
        self.scanTableView.reloadData()
    }
}
