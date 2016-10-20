//
//  ViewController.swift
//  PodTest
//
//  Created by Jaime Hernandez on 10/18/16.
//  Copyright © 2016 Jaime Hernandez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import SwiftCharts



class ViewController: UIViewController {

    var phData = [Double]()
    var resData = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Create a new class for the retrival of data?
        let myUrl: String = "https://grogdata.soest.hawaii.edu/poh/data/node-021/PH_EXT.json?minutes=10080"
        
        Alamofire.request(myUrl).responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                // After serialization grab the data arrays - there are two of them....
                self.resData = swiftyJsonVar["samples"]["ReceptionTime"].arrayObject as! [Double]
                self.phData = swiftyJsonVar["samples"]["PH_EXT"].arrayObject as! [Double]

                // loop through the arrays and write out the data....
                
                let NewFormat = DateFormatter()
                NewFormat.dateFormat = "MM-dd-yyyy HH:mm:ss"
                
                for i in 0 ..< self.resData.count {
                    // let TimeStamp : Double = self.resData[i]
                    let NewDateTime = NSDate(timeIntervalSince1970: self.resData[i] as Double)
                    let NewDateToo = NewFormat.string(from: NewDateTime as Date)
                    print("Count is \(i) the PH Level is \(self.phData[i]) and the date is \(NewDateToo)")
                    
                    // TODO: - create an array to pass to the chart library...
                    // TODO: Wire up the storyboard to accept the new functionality
                    
                }
             }
        }
    }
}

