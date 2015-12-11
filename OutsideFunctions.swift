//
//  OutsideFunctions.swift
//  TipCalc
//
//  Created by Jordi Turner on 12/7/15.
//  Copyright © 2015 Jordi Turner. All rights reserved.
//

import Foundation
class OutsideFunctions {
    
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : OutsideFunctions? = nil
    }
    
    class var sharedInstance : OutsideFunctions {
        dispatch_once(&Static.onceToken) {
            Static.instance = OutsideFunctions()
        }
        return Static.instance!
    }
    
    var SubtotalAmount: [String:AnyObject]
    
    init() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if let SubtotalAmountInfo = userDefaults.objectForKey("SubtotalAmountKey") as? [String:AnyObject] {
            SubtotalAmount = SubtotalAmountInfo
        }
        else {
            SubtotalAmount = [
                "value": 0,
                "timestamp": NSDate()
            ]
        }
    }
    
    func saveData() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(SubtotalAmount, forKey: "SubtotalAmountKey")
        userDefaults.synchronize()
    }
    
    func getSubtotalAmount() -> Double? {
        let SinceLastChanged = NSDate().timeIntervalSinceDate(SubtotalAmount["timestamp"] as! NSDate)
        let SubtotalAmountValue = SubtotalAmount["value"] as! Double
        if SubtotalAmountValue > 0 && SinceLastChanged < 300 {
            return SubtotalAmountValue
        } else {
            return nil
        }
    }
    
    func setSubtotalAmount(newSubtotalAmount: Double) {
        SubtotalAmount = [
            "value": newSubtotalAmount,
            "timestamp": NSDate()
        ]
        saveData()
    }
    
    
}