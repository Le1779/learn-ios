//
//  CustomCellViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/2/7.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class CustomCellViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    extension CustomCellViewController :UITableViewDelegate,UITableViewDataSource{
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
