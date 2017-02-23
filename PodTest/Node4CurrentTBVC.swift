//
//  Node4CurrentTBVC.swift
//  PodTest
//
//  Created by Jaime Hernandez on 1/25/17.
//  Copyright © 2017 Jaime Hernandez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation


class Node4CurrentTBVC: UITableViewController {

    var nodeArray = [String]()
    var currentTemp = Double()
    let currentO2Con = Double()
    let currentPressure = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myUrlTemp: String = "https://grogdata.soest.hawaii.edu/poh/data/node-004/Temperature.json?minutes=15&max_count=1"
        let myUrlO2:   String = "https://grogdata.soest.hawaii.edu/poh/data/node-004/O2Concentration.json?minutes=15&max_count=1"
        let myUrlPressure: String = "https://grogdata.soest.hawaii.edu/poh/data/location/makaha1/depth.json?minutes=15&max_count=1"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(myUrlTemp).validate().responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                let stringTemp = swiftyJsonVar["samples"]["Temperature"].arrayObject as! [Int]
                
                var appendTemp:String = String(format: "%f", stringTemp)
                appendTemp = "Temperature is " + stringTemp.description + " ° C"
                
                self.nodeArray.append(appendTemp)
                self.tableView.reloadData()
                
                }
            
            Alamofire.request(myUrlO2).validate().responseJSON { (responseData) -> Void in
                if ((responseData.result.value) != nil) {
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    let currentO2Con = swiftyJsonVar["samples"]["O2Concentration"].arrayObject as! [Int]
                    
                    var appendO2Con:String = String(format: "%f", currentO2Con)
                    appendO2Con = "O2 Concentration is " + currentO2Con.description + " in uM"
                    
                    self.nodeArray.append(appendO2Con)
                    self.tableView.reloadData()
                }
                
                
                Alamofire.request(myUrlPressure).validate().responseJSON { (responseData) -> Void in
                    if ((responseData.result.value) != nil) {
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        let swiftyJsonVar = JSON(responseData.result.value!)
                        let currentPressureTemp = swiftyJsonVar["depth"].arrayObject as! [Float]
                        
                        let appendPressure = "Depth in Meters is " + currentPressureTemp.description
                        
                        self.nodeArray.append(appendPressure)
                        self.tableView.reloadData()
                    }

                }
            }
        }
        
        self.tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nodeArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.nodeArray[indexPath.row] // .description // casting to String with description
        return cell

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
