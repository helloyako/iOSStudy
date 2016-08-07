//
//  MyUITextField.swift
//  Homepwner
//
//  Created by helloyako on 2016. 8. 7..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class MyUITextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        self.borderStyle = UITextBorderStyle.Line
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        self.borderStyle = UITextBorderStyle.RoundedRect
        return super.resignFirstResponder()
    }

}
