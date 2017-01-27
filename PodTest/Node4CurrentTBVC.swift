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

    var nodeArray = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myUrlTemp: String = "https://grogdata.soest.hawaii.edu/poh/data/node-004/Temperature.json?minutes=1&max_count=1"
        let myUrlO2:   String = "https://grogdata.soest.hawaii.edu/poh/data/node-004/O2Concentration.json?minutes=1&max_count=1"
        let myUrlPressure: String = "https://grogdata.soest.hawaii.edu/poh/data/location/makaha1/depth.json?minutes=1&max_count=1"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(myUrlTemp).validate().responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                let swiftyJsonVar = JSON(responseData.result.value!)
                let arrayTemp = swiftyJsonVar["samples"]["Temperature"].doubleValue
                // let newTemp = String(describing: arrayTemp)
                
                self.nodeArray.append(arrayTemp)
                
                print(arrayTemp)
                }
        }
            Alamofire.request(myUrlO2).validate().responseJSON { (responseData) -> Void in
                if ((responseData.result.value) != nil) {
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    let arrayO2 = swiftyJsonVar["samples"]["O2Concentration"].doubleValue
                    // let arrayO2 = swiftyJsonVar["samples"]["O2Concentration"].arrayObject as! [Double]
                    // let newO2 = String(describing: arrayO2)
                    self.nodeArray.append(arrayO2)
                    
                    self.tableView.reloadData()
                    print(arrayO2)
                }
                
        }
        
        Alamofire.request(myUrlPressure).validate().responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                let swiftyJsonVar = JSON(responseData.result.value!)
                let arrayPressure = swiftyJsonVar["depth_meter"].doubleValue
                // let arrayPressure = swiftyJsonVar["depth_meter"].arrayObject as! [Double]
                // let newPressure = String(describing: arrayPressure)
                self.nodeArray.append(arrayPressure)
                
                self.tableView.reloadData()
                print(arrayPressure)
            }
            
        }

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
        cell.textLabel?.text = self.nodeArray[indexPath.row].description // casting to String with description
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
