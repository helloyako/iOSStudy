//
//  ItemStore.swift
//  Homepwner
//
//  Created by helloyako on 2016. 7. 31..
//  Copyright © 2016년 helloyako. All rights reserved.
//

import Foundation

class ItemStore {
    var allItems = [Item]()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as? [Item] {
            allItems += archivedItems
        }
    }
    
    let itemArchiveURL: NSURL = {
        let documentDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentDirectories.first!
        
        return documentDirectory.URLByAppendingPathComponent("items.archive")
    }()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if(fromIndex == toIndex) {
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.removeAtIndex(toIndex)
        
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving items to : \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path!)
    }
}