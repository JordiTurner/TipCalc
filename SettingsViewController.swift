//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Jordi Turner on 12/7/15.
//  Copyright © 2015 Jordi Turner. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var CustomLabel: UILabel!
    @IBOutlet weak var DefaultLabel: UILabel!
    @IBOutlet weak var ThemeLabel: UILabel!
    @IBOutlet weak var CustomField: UITextField!
    @IBOutlet weak var DefaultSegControl: UISegmentedControl!
    @IBOutlet weak var ThemeSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.CustomField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let CustomTip = defaults.doubleForKey("CustomTip_Key")
        let ThemeSelect = defaults.integerForKey("ThemeSelect_Key")
        let DefaultPercentage = defaults.integerForKey("DefaultPercentage_Key")
        
        let CustomTipString:String = String(format:"%3.0f", CustomTip)
        CustomField.text = "\(CustomTipString)"
        
        DefaultSegControl.selectedSegmentIndex = DefaultPercentage
        
        ThemeSegControl.selectedSegmentIndex = ThemeSelect
        
        if ThemeSelect == 0 {
            LightTheme()
        }
        else if ThemeSelect == 1{
            DarkTheme()
        }
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.CustomField.becomeFirstResponder()
    }
    @IBAction func TipSettingsChange(sender: AnyObject) {
        
        let CustomTip = NSString(string: CustomField.text!).doubleValue
        let DefaultPercentage = DefaultSegControl.selectedSegmentIndex
        
        print(DefaultPercentage)
        //Pass CustomTip, DefaultPercentage
        
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(CustomTip, forKey: "CustomTip_Key")
        defaults.setInteger(DefaultPercentage, forKey: "DefaultPercentage_Key")
        defaults.synchronize()
        
    }
    
    @IBAction func ThemeChanged(sender: AnyObject) {
        let ThemeSelect = ThemeSegControl.selectedSegmentIndex
        
        //Pass ThemeSelect
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(ThemeSelect, forKey: "ThemeSelect_Key")
        defaults.synchronize()
        
        if ThemeSelect == 0 {
            LightTheme()
        }
        else if ThemeSelect == 1{
            DarkTheme()
        }
    }
    func DarkTheme() {
        let MainColor = UIColor(red: 43/255, green: 117/255, blue: 167/255, alpha: 1) //blue background
        let AccentColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //white accent
        self.view.backgroundColor = MainColor
        self.CustomLabel.textColor = AccentColor
        self.DefaultLabel.textColor = AccentColor
        self.DefaultSegControl.tintColor = AccentColor
        self.ThemeSegControl.tintColor = AccentColor
        self.ThemeLabel.textColor = AccentColor
        self.CustomField.textColor = MainColor
    }
    func LightTheme() {
        let MainColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1) //white background
        let AccentColor = UIColor(red: 43/255, green: 117/255, blue: 167/255, alpha: 1) //blue accent
        self.view.backgroundColor = MainColor
        self.view.backgroundColor = MainColor
        self.CustomLabel.textColor = AccentColor
        self.DefaultLabel.textColor = AccentColor
        self.DefaultSegControl.tintColor = AccentColor
        self.ThemeSegControl.tintColor = AccentColor
        self.ThemeLabel.textColor = AccentColor
        self.CustomField.textColor = AccentColor
    }

}
