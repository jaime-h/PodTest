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
import ScrollableGraphView

extension Double {
        /// Rounds the double to decimal places value
        /// http://stackoverflow.com/questions/27338573/rounding-a-double-value-to-x-number-of-decimal-places-in-swift?noredirect=1&lq=1
        func roundTo(places:Int) -> Double {
            let divisor = pow(10.0, Double(places))
            return (self * divisor).rounded() / divisor
        }
    }
@IBDesignable
class ViewController: UIViewController {

    var phData = [Double]()
    var resData = [Double]()
    var dateData = [String]()
    var maxPh:Double = 0.0
    
    typealias dataPoint = (dateStamp: String, value: Float)
    var dataPoints = [dataPoint]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Create a new class for the retrival of data?
        // Changed to pull data for 5 days...
        let myUrl: String = "https://grogdata.soest.hawaii.edu/poh/data/node-021/PH_EXT.json?minutes=7200"
        
        Alamofire.request(myUrl).responseJSON { (responseData) -> Void in
            if ((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                // After serialization grab the data arrays - there are two of them....
                self.resData = swiftyJsonVar["samples"]["ReceptionTime"].arrayObject as! [Double]
                self.phData = swiftyJsonVar["samples"]["PH_EXT"].arrayObject as! [Double]
                
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
                
                
            }

        }
    }
}

