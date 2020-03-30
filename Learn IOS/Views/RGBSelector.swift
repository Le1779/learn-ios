//
//  RGBTableViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/3/29.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class RGBSelector: UITableViewController {
    
    let rgbItem: [UIColor] = [.black, .white, .red, .orange, .yellow, .green, .blue, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(RGBSelectorCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
        self.view.backgroundColor = .clear
        tableView.backgroundColor = .clear
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rgbItem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RGBSelectorCell
        cell.setColor(color: rgbItem[indexPath.row])
        cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
        cell.backgroundColor = .clear

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    class RGBSelectorCell: UITableViewCell {
        
        public func setColor(color: UIColor) {
            let viewWidth = self.frame.height
            let margin = viewWidth/6
            let colorView = UIView()
            colorView.frame = CGRect(x: margin, y: margin, width: viewWidth - margin*2, height: viewWidth - margin*2)
            colorView.backgroundColor = color
            colorView.layer.cornerRadius = viewWidth/2 - margin
            colorView.clipsToBounds = true
            let shadowLayer = ShadowLayer(frame: colorView.frame, bounds: colorView.bounds, cornerRadius: colorView.layer.cornerRadius)
            self.addSubview(shadowLayer)
            self.addSubview(colorView)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
