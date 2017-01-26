//
//  RootRealTimeTBVC.swift
//  TBVCTest
//
//  Created by Jaime Hernandez on 1/22/17.
//  Copyright © 2017 Jaime Hernandez. All rights reserved.
//

import UIKit

class RootRealTimeTBVC: UITableViewController {

    var pondSites = ["Node 4", "Node 9", "Node 25"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return pondSites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = pondSites[indexPath.row]
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0, 3, 6:
            let vc = "24Hours"
            let viewController = storyboard?.instantiateViewController(withIdentifier: vc)
            self.navigationController?.pushViewController(viewController!, animated: true)
        case 1, 4, 7:
            let vc = "OneWeek"
            let viewController = storyboard?.instantiateViewController(withIdentifier: vc)
            self.navigationController?.pushViewController(viewController!, animated: true)
        case 2, 5, 8:
            let vc = "OneMonth"
            let viewController = storyboard?.instantiateViewController(withIdentifier: vc)
            self.navigationController?.pushViewController(viewController!, animated: true)
        default:
            let vc = "OneWeek"
            let viewController = storyboard?.instantiateViewController(withIdentifier: vc)
            self.navigationController?.pushViewController(viewController!, animated: true)
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
