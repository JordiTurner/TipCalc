//
//  ViewController.swift
//  TipCalc
//
//  Created by Jordi Turner on 12/6/15.
//  Copyright © 2015 Jordi Turner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var SubtotalCurrencyLabel: UILabel!
    @IBOutlet weak var SubtotalField: UITextField!
    @IBOutlet weak var SplitField: UITextField!
    @IBOutlet weak var TipLabel: UILabel!
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var TipSegControl: UISegmentedControl!
    @IBOutlet weak var Split: UILabel!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var Tip: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SubtotalField.text = ""
        if let SubtotalAmount = OutsideFunctions.sharedInstance.getSubtotalAmount() {
            SubtotalField.text = SubtotalAmount.description
        }
        SubtotalCurrencyLabel.text = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.SubtotalField.becomeFirstResponder()
        let defaults = NSUserDefaults.standardUserDefaults()
        let ThemeSelect = defaults.integerForKey("ThemeSelect_Key")
        let DefaultPercentage = defaults.integerForKey("DefaultPercentage_Key")
        TipSegControl.selectedSegmentIndex = DefaultPercentage
        if ThemeSelect == 0 {
            LightTheme()
        }
        else if ThemeSelect == 1{
            DarkTheme()
        }
        TipCalc()
    }
    
    @IBAction func OnEditingChange(sender: AnyObject) {
        TipCalc()
    }

    func TipCalc() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let CustomTip = defaults.doubleForKey("CustomTip_Key")
        var SelectedPercentage = [0.1,0.15,0.2,CustomTip/100]
        let SubtotalAmount = NSString(string: SubtotalField.text!).doubleValue
        let SplitNum = NSString(string: SplitField.text!).doubleValue
        
        var TipNum = SubtotalAmount * SelectedPercentage[TipSegControl.selectedSegmentIndex]/SplitNum
        var TotalNum = (SubtotalAmount/SplitNum) + TipNum
        if TipNum .isInfinite || TipNum .isNaN{
            TipNum = 0
            TotalNum = 0
        }
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        let TotalString = formatter.stringFromNumber(TotalNum)
        let TipString = formatter.stringFromNumber(TipNum)
        let SubtotalString : String? = formatter.locale.objectForKey(NSLocaleCurrencySymbol) as? String
        TipLabel.text = TipString!
        TotalLabel.text = TotalString!
        SubtotalCurrencyLabel.text = SubtotalString
        OutsideFunctions.sharedInstance.setSubtotalAmount(SubtotalAmount)
        if SubtotalAmount == 0 {
            HideView()
        }
        else {
            ShowView()
        }
    }
    func ShowView() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.TipLabel.alpha = 1
            self.TipLabel.center.x  = 119
            self.TotalLabel.alpha = 1
            self.TotalLabel.center.x  = 119
            self.SplitField.alpha = 1
            self.SplitField.center.x = 261.5
            self.TipSegControl.alpha = 1
            self.TipSegControl.center.y = 241.5
            self.Tip.alpha = 1
            self.Tip.center.x = 29
            self.Total.alpha = 1
            self.Total.center.x  = 29
            self.Split.alpha = 1
            self.Split.center.x = 261.5
            self.SubtotalCurrencyLabel.alpha = 1
            self.SubtotalCurrencyLabel.center.x = 24.5
            self.SubtotalField.alpha = 1
            self.SubtotalField.center.x = 160.5
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    func HideView() {
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.TipLabel.alpha = 0
            self.TipLabel.center.x  = 119 - 320
            self.TotalLabel.alpha = 0
            self.TotalLabel.center.x  = 119 - 320
            self.SplitField.alpha = 0
            self.SplitField.center.x = 261.5 + 320
            self.TipSegControl.alpha = 0
            self.TipSegControl.center.y = 241.5 + 150
            self.Tip.alpha = 0
            self.Tip.center.x = 66.5 - 320
            self.Total.alpha = 0
            self.Total.center.x  = 29 - 320
            self.Split.alpha = 0
            self.Split.center.x = 261.5 + 320
            self.SubtotalCurrencyLabel.alpha = 0.5
            self.SubtotalCurrencyLabel.center.x = 160.5
            self.SubtotalField.alpha = 0
            self.SubtotalField.center.x = 160.5
            self.view.layoutIfNeeded()
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    func DarkTheme() {
        let MainColor = UIColor(red: 43/255, green: 117/255, blue: 167/255, alpha: 1) //blue background
        let AccentColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //white accent
        self.view.backgroundColor = MainColor
        self.TipLabel.textColor = AccentColor
        self.TotalLabel.textColor = AccentColor
        self.SplitField.textColor = AccentColor
        self.TipSegControl.tintColor = AccentColor
        self.Tip.textColor = AccentColor
        self.Total.textColor = AccentColor
        self.Split.textColor = AccentColor
        self.Split.textColor = AccentColor
        self.SubtotalCurrencyLabel.textColor = AccentColor
        self.SubtotalField.textColor = AccentColor
    }
    func LightTheme() {
        let MainColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //white background
        let AccentColor = UIColor(red: 43/255, green: 117/255, blue: 167/255, alpha: 1) //blue accent
        self.view.backgroundColor = MainColor
        self.TipLabel.textColor = AccentColor
        self.TotalLabel.textColor = AccentColor
        self.SplitField.textColor = AccentColor
        self.TipSegControl.tintColor = AccentColor
        self.Tip.textColor = AccentColor
        self.Total.textColor = AccentColor
        self.Split.textColor = AccentColor
        self.Split.textColor = AccentColor
        self.SubtotalCurrencyLabel.textColor = AccentColor
        self.SubtotalField.textColor = AccentColor
    }

}