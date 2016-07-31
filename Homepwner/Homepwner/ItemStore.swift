//
//  ItemStore.swift
//  Homepwner
//
//  Created by helloyako on 2016. 7. 31..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import Foundation

class ItemStore {
    var under50Items = [Item]()
    var over50Items = [Item]()
    
    init() {
        for _ in 0..<50 {
            createItem()
        }
    }
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        if newItem.valueInDollars > 50 {
            over50Items.append(newItem)
        } else {
            under50Items.append(newItem)
        }
        
        return newItem
    }
}