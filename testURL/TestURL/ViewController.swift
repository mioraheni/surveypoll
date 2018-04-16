//
//  ViewController.swift
//  fluxRSS
//
//  Created by admin on 08/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//
//Envoyer à manuel.deneu@gmail.com
//Objet : SWIFT
import UIKit

class ViewController: UIViewController, DBDelegate {
    
    @IBOutlet var labelTitle : UILabel!
    
    let dbController = DataBaseController()

    func dataLoaded(datas: ItunesAPIResults?) {
        
        
        guard let datas = datas else
        {
            print("ok")
            return
        }
        
        //labelTitle.text = datas.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dbController.delegate = self
        dbController.load()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

