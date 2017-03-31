//
//  ViewController.swift
//  Buggy
//
//  Created by helloyako on 2017. 3. 30..
//  Copyright © 2017년 helloyako. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        print("Method: \(#function) in file: \(#file) line: \(#line) callded")
        
        bedMethod()
        
    }

    func bedMethod() {
        let array = NSMutableArray()
        
        for i in 0..<10 {
            array.insert(i, at: i)
        }
        
        for _ in 0..<10 {
            array.remove(at: 0)
        }
    }
}

