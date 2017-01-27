//
//  OneDayOxygenScrollView.swift
//  PodTest
//
//  Created by Jaime Hernandez on 1/26/17.
//  Copyright © 2017 Jaime Hernandez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation
import ScrollableGraphView

@IBDesignable
class OneDayOxygenScrollView: UIViewController {
    
        var phData = [Double]()
        var resData = [Double]()
        var dateData = [String]()
        var maxPh:Double = 0.0
        
        
        
        typealias dataPoint = (dateStamp: String, value: Float)
        var dataPoints = [dataPoint]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // TODO: - Create a new class for the retrival of data?
            // Changed to pull data for 1 days
            let myUrl: String = "https://grogdata.soest.hawaii.edu/poh/data/node-004/O2Concentration.json?minutes=1440&max_count=150"
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            Alamofire.request(myUrl).validate().responseJSON { (responseData) -> Void in
                if ((responseData.result.value) != nil) {
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    // After serialization grab the data arrays - there are two of them....
                    self.resData = swiftyJsonVar["samples"]["ReceptionTime"].arrayObject as! [Double]
                    self.phData = swiftyJsonVar["samples"]["O2Concentration"].arrayObject as! [Double]
                    
                    // loop through the arrays and write out the data....
                    
                    let NewFormat = DateFormatter()
                    NewFormat.dateFormat = "MM/dd HH:mm:ss"
                    
                    let maxPh = self.phData.max()
                    let minPh = self.phData.min()
                    
                    for i in 0 ..< self.resData.count {
                        let NewDateTime = NSDate(timeIntervalSince1970: self.resData[i] as Double)
                        let NewDateToo = NewFormat.string(from: NewDateTime as Date)
                        // let newPH = Double(self.phData[i].roundTo(places: 4))
                        // self.dataPoints.append((dateStamp: NewDateToo, value: Float(self.phData[i])))
                        self.dateData.append(NewDateToo)
                        
                        // TODO: - create an array to pass to the chart library...
                        // TODO: Wire up the storyboard to accept the new functionality
                        
                    }
                    
                    let graphView = ScrollableGraphView(frame: self.view.frame)
                    let phData = self.phData
                    let labels = self.dateData
                    
                    graphView.shouldAnimateOnStartup = false
                    graphView.numberOfIntermediateReferenceLines = 5
                    graphView.referenceLineNumberOfDecimalPlaces = 4
                    
                    graphView.rangeMin = minPh! as Double
                    graphView.rangeMax = maxPh! as Double
                    
                    graphView.dataPointSpacing = 2.0
                    
                    // graphView.shouldAutomaticallyDetectRange = true
                    // graphView.shouldAdaptRange = true
                    graphView.dataPointLabelsSparsity = 75
                    graphView.lineColor = UIColor(red:0.00, green:0.75, blue:1.00, alpha:1.0)
                    graphView.dataPointLabelColor = UIColor(red:0.00, green:0.75, blue:1.00, alpha:1.0)
                    graphView.dataPointFillColor = UIColor(red:0.00, green:0.75, blue:1.00, alpha:1.0)
                    
                    graphView.set(data: phData, withLabels: labels)
                    self.view.addSubview(graphView)
                    
                    
                } else {
                    // No good connection - Display network error
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                    let ac = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: UIAlertControllerStyle.alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    }
                    ac.addAction(okAction)
                    self.present(ac, animated: true, completion: nil)
                    
                }
                
                func okAction() {
                    print("Back to Network")
                }
                
            }
        }
}

