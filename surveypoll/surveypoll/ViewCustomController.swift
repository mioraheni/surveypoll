//
//  ViewCustomController.swift
//  surveypoll
//
//  Created by Henintsoa Miora on 15/04/2018.
//  Copyright © 2018 Hauret Xiong. All rights reserved.
//

import UIKit
import Foundation

class ViewCustomController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if (identifier == "goToSurvey"){
            if let userId = UserDefaults.standard.object(forKey: "userId") as? Int {
                print(userId)
            }
            if let textField = nameTextField.text as? String{
                if(textField != ""){
                    
                    let customURL = "surveypoll/\(textField)"
                    let url = "https://www.teamoppai.fr/sondage/voirUnSondage.php?url=\(customURL)&iduser="
                    UserDefaults.standard.set(url, forKey:"survey");
                    UserDefaults.standard.synchronize();
                    return true
                }
            }
            return false
        }else{
            return false
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
