//
//  ItemStore.swift
//  Homepwner
//
//  Created by helloyako on 2017. 4. 1..
//  Copyright © 2017년 helloyako. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            let _ = createItem()
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
}
