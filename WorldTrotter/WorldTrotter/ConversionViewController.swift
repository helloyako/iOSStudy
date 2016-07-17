//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by helloyako on 2016. 7. 15..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    let letterCharacterSet = NSCharacterSet.letterCharacterSet()
    
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * (5/9)
        } else {
            return nil
        }
    }
    
    @IBAction func fahrenhitFieldEditingChanged(sender: UITextField) {
        if let text = sender.text, value = Double(text) {
            fahrenheitValue = value
        } else {
            fahrenheitValue = nil
        }
        
    }
    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.rangeOfString(".") != nil && string.rangeOfString(".") != nil) || string.rangeOfCharacterFromSet(letterCharacterSet) != nil {
            return false
        } else {
            return true
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let now = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH"
        let hour: Int = Int(dateFormatter.stringFromDate(now))!
        
        switch hour {
        case 0...6:
            fallthrough
        case 18...24:
            view.backgroundColor = UIColor.darkGrayColor()
        default:
            view.backgroundColor = UIColor.whiteColor()
        }
    }
}
