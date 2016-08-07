//
//  DateChangeViewController.swift
//  Homepwner
//
//  Created by helloyako on 2016. 8. 7..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import UIKit

class DateChangeViewController: UIViewController {
    
    var item: Item!

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Date Change"
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        item.dateCreated = datePicker.date
    }
}
