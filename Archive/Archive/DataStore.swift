//
//  DataStore.swift
//  Archive
//
//  Created by Henintsoa Miora on 05/03/2018.
//  Copyright © 2018 Henintsoa Miora. All rights reserved.
//

import UIKit

class Value : NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
    }
    
    override init()
    {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let title = aDecoder.decodeObject(forKey: "title") as? String
        {
            self.title = title
        }
    }
    var title = ""
}

class Item : NSObject,NSCoding
{
    static let keyName = "identifier"
    static let keyID = "id"
    static let keyValue = "value"
    
    static let InvalidID = 0
    
    override init()
    {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(id, forKey: "id")
        
        aCoder.encode(value.title, forKey: "value.title")
    }
    
    required init?(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObject(forKey: "name") as? String
        {
            self.name = name
        }else {
            self.name = ""
        }
        
        if let id = aDecoder.decodeObject(forKey: "id") as? Int
        {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let value = aDecoder.decodeObject(forKey: "value") as? Value
        {
            self.value = value
        }
        
    }
    
    var name = ""
    var id = 0
    
    var value = Value()
}

class DataStore: NSObject {

    var itemList = [Item]()
    
    private var filePath : String
    {
        get {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            
            let path = url!.appendingPathComponent("Data").path
            
            return path
        }
    }
    
    func loadToFile() -> Bool
    {
        if let data = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Item]
        {
            self.itemList = data
            return true
        }
        return false
    }
    
    func saveToFile() -> Bool
    {
        return NSKeyedArchiver.archiveRootObject(itemList, toFile: filePath)
    }
    
}
