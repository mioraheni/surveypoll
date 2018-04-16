//
//  ViewController.swift
//  Archive
//
//  Created by Henintsoa Miora on 05/03/2018.
//  Copyright © 2018 Henintsoa Miora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var db = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (db.loadToFile())
        {
            print("Load ok")
        }else{
            print("Load error")
        }
        
        let item = Item()
        item.name = "Toto"
        item.id = 12
        db.itemList.append(item)
        
        if (db.saveToFile())
        {
            print("Save Ok")
        }else
        {
            print("Save error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

