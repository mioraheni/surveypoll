//
//  ViewController.swift
//  surveypoll
//
//  Created by Henintsoa Miora on 08/03/2018.
//  Copyright © 2018 Hauret Xiong. All rights reserved.
//

import UIKit
import Foundation
class LoginController: UIViewController {

    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var error: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        @IBOutlet UILabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if let loginUser = login.text as? String{
            if let passUser = pass.text as? String{
                if(loginUser == "admin" && passUser == "admin"){
                    UserDefaults.standard.set(loginUser, forKey:"login");
                    UserDefaults.standard.set(1, forKey:"userId");
                    UserDefaults.standard.synchronize();
                    return true
                }else if(loginUser == "admin2" && passUser == "admin2"){
                    UserDefaults.standard.set(loginUser, forKey:"login");
                    UserDefaults.standard.set(2, forKey:"userId");
                    UserDefaults.standard.synchronize();
                    return true
                }
            }
        }
        error.text = "Mauvais identifiant ou mot de passe"
        return false
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
     
     
        var controller = segue.destination as! MyViewController
        controller.user =
    }
 */

}

