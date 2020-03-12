//
//  LearnBLEViewController.swift
//  Learn IOS
//  學習如何操作BLE，目標：搜尋 連線 斷線 Read/Write
//  Created by Kevin Le on 2020/1/17.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit
import CoreBluetooth

class LearnBLEViewController: UIViewController {
    
    @IBOutlet weak var scanTableView: UITableView!
    //藍牙管理物件
    var manager: CBCentralManager!
    var discoveredPeripheralsArr: [CBPeripheral?] = []
    
    //连接的外围
    var connectedPeripheral : CBPeripheral!
    //保存的设备特性
    var savedCharacteristic : CBCharacteristic!
    
    var lastString : NSString!
    var sendString : NSString!

    //需要连接的 CBCharacteristic 的 UUID
    let ServiceUUID1 =  "FFE0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         tableView = UITableView.init(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: UITableView.Style.plain)
         tableView.delegate = self;
         tableView.dataSource = self;
         self.view.addSubview(tableView)
         
         
         let leftButton = UIButton.init(type: UIButton.ButtonType.custom)
         leftButton.frame = CGRect(x: 0,y: 0,width: 60,height: 20)
         leftButton.setTitle("Scan", for: UIControl.State.normal)
         leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
         leftButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
         //leftButton.addTarget(self, action: #selector(LearnBLEViewController.startScan), for: UIControl.Event.touchUpInside)
         self.view.addSubview(leftButton)
         //self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
         */
        
        self.scanTableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        manager = CBCentralManager.init(delegate: self, queue: DispatchQueue.main)
    }
    
    @IBAction func OnScanButtonClick(_ sender: Any) {
        startScan()
    }

    /**
     連接裝置
     */
    func connectDevice(){}
    
    /**
     中斷連線
     */
    func disconnectDevice(){}
    
    /***/
    func startScan(){
        print("Start Scan")
        manager.scanForPeripherals(withServices: nil, options: nil)
    }
    
    /***/
    func stopScan(){}
    
}

// MARK: - TableViewController
extension LearnBLEViewController :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredPeripheralsArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) 
        let peripheral = discoveredPeripheralsArr[indexPath.row]
        
        if peripheral?.name != nil{
            cell.textLabel?.text = String.init(format: "Device Name: %@", (peripheral?.name)!)
        } else{
            cell.textLabel?.text = "No Name"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPeripheral = discoveredPeripheralsArr[indexPath.row]
        //連結裝置
        manager.connect(selectedPeripheral!, options: nil)
    }
}

// MARK: - CBCentralManager
extension LearnBLEViewController :CBCentralManagerDelegate{
    
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
        for obtainedPeriphal  in discoveredPeripheralsArr {
            if (obtainedPeriphal?.identifier == peripheral.identifier){
                isExisted = true
            }
        }
        
        if !isExisted{
        discoveredPeripheralsArr.append(peripheral)
        }
        
        self.scanTableView.reloadData()
    }
    
    /**連接成功*/
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("didConnect")
    }
    
    /**連接失敗*/
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("didFailToConnect")
    }
    
    /**中斷連線*/
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("didDisconnectPeripheral")
    }
}
    
    /**
     @objc func startScan() {
             print("扫描设备")
             manager.scanForPeripherals(withServices: nil, options: nil)
         }
         
         
         //UITableViewDelegate,UITableViewDataSource
         

         

         //写入数据
         func viewController(_ peripheral: CBPeripheral,didWriteValueFor characteristic: CBCharacteristic,value : Data ) -> () {
             
             //只有 characteristic.properties 有write的权限才可以写
             if characteristic.properties.contains(CBCharacteristicProperties.write){
                 //设置为  写入有反馈
                 self.connectedPeripheral.writeValue(value, for: characteristic, type: .withResponse)
             }else{
                 print("写入不可用~")
             }
         }
         

         
         
         
         
         
         
         override func didReceiveMemoryWarning() {
             super.didReceiveMemoryWarning()
             // Dispose of any resources that can be recreated.
         }


     }

     
     extension LearnBLEViewController :CBCentralManagerDelegate,CBPeripheralDelegate{
         
         
         

         
         //连接上
         func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral){
             connectedPeripheral = peripheral
             //外设寻找service
             peripheral .discoverServices(nil)
             
             peripheral.delegate = self
             self.title = peripheral.name
             manager .stopScan()
             
             let alertController = UIAlertController.init(title: "已连接上 \(peripheral.name)", message: nil, preferredStyle: .alert)
             self.present(alertController, animated: true) {
             
                 alertController.dismiss(animated: false, completion: {
                     //连接上后跳转
                     //let inputController = InputValueController.init()
                     //self.present(inputController, animated: true) {
                     //}
                     //inputController.imputValueBlock = { (sendStr ) -> () in
                     //    self.sendString = sendStr as NSString!
                     //    let data = sendStr?.data(using: .utf8)
                     //    self.viewController(self.connectedPeripheral , didWriteValueFor :self.savedCharacteristic, value: data!)
                     //}
                 })
             }
         }
         
         //连接到Peripherals-失败
         func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?){
             print("连接到名字为 \(peripheral.name) 的设备失败，原因是 \(error?.localizedDescription)")

         }
         ///断开
         func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?){
             print("连接到名字为 \(peripheral.name) 的设备断开，原因是 \(error?.localizedDescription)")

             let alertView = UIAlertController.init(title: "抱歉", message: "蓝牙设备\(peripheral.name)连接断开，请重新扫描设备连接", preferredStyle: UIAlertController.Style.alert)
             alertView.show(self, sender: nil)
             
         }
         // CBPeripheralDelegate
         
         //扫描到Services
         func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?){
             
             if (error != nil){
                 print("查找 services 时 \(peripheral.name) 报错 \(error?.localizedDescription)")
             }

             for service in peripheral.services! {
                 //需要连接的 CBCharacteristic 的 UUID
                 if service.uuid.uuidString == ServiceUUID1{
                     
                     peripheral.discoverCharacteristics(nil, for: service)
                 }
             }
         }
         
         
         //扫描到 characteristic
         func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?){
             if error != nil{
                 print("查找 characteristics 时 \(peripheral.name) 报错 \(error?.localizedDescription)")
             }
             
             //获取Characteristic的值，读到数据会进入方法：
     //        func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?)
             
             for characteristic in service.characteristics! {
                 peripheral .readValue(for: characteristic)
                 
                 
                 //设置 characteristic 的 notifying 属性 为 true ， 表示接受广播
                 
                 peripheral.setNotifyValue(true, for: characteristic)
             }
         }
         
         
         //获取的charateristic的值
         func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?){
             
             let resultStr = NSString(data: characteristic.value!, encoding: String.Encoding.utf8.rawValue)
             
             print("characteristic uuid:\(characteristic.uuid)   value:\(resultStr)")
             
             if lastString == resultStr{
                 return;
             }
             
             // 操作的characteristic 保存
             self.savedCharacteristic = characteristic
         }
         
         
         
         func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?){
             if error != nil{
                 print("写入 characteristics 时 \(peripheral.name) 报错 \(error?.localizedDescription)")
             }
             
             let alertView = UIAlertController.init(title: "抱歉", message: "写入成功", preferredStyle: UIAlertController.Style.alert)
             let cancelAction = UIAlertAction.init(title: "好的", style: .cancel, handler: nil)
             alertView.addAction(cancelAction)
             alertView.show(self, sender: nil)
             lastString = NSString(data: characteristic.value!, encoding: String.Encoding.utf8.rawValue)

         }
     */

