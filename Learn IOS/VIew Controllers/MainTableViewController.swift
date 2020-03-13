//
//  PageTableViewController.swift
//  Learn IOS
//
//  Created by Kevin Le on 2020/1/17.
//  Copyright © 2020 Kevin Le. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    // MARK: - Table view data source
    
    var testList = [
        PageList(sectionName: "UIKit", pages: [Page(name: "Button", id: "learnButtonPage"),
                                               Page(name: "TextField", id: "learnTextFieldPage"),
                                               Page(name: "Bottom Sheet", id: "learnBottomSheetPage")]),
        PageList(sectionName: "Bluetooth", pages: [Page(name: "Scan", id: "learnBLEScanPage"),
                                                   Page(name: "BLE", id: "learnBLEPage")]),
        PageList(sectionName: "Homework", pages: [Page(name: "BmiCalculator", id: "layout_bmi_calculator")])
    ]
    
    class PageList{
        var sectionName: String
        var pages: [Page]
        
        init(sectionName: String, pages: [Page]) {
            self.sectionName = sectionName
            self.pages = pages
        }
    }
    
    class Page {
        var name : String
        var id: String
        
        init(name: String, id: String) {
            self.name = name
            self.id = id
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.testList[section].sectionName
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return testList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.testList[section].pages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) 
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
        // Configure the cell...
        cell.textLabel?.text = self.testList[indexPath.section].pages[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let title = self.testList[indexPath.section].pages[indexPath.row].name
        print("selected \(title)")
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: self.testList[indexPath.section].pages[indexPath.row].id) {
            present(controller, animated: true, completion: nil)
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
