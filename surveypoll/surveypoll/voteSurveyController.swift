//
//  voteSurveyController.swift
//  surveypoll
//
//  Created by Henintsoa Miora on 16/04/2018.
//  Copyright © 2018 Hauret Xiong. All rights reserved.
//

import UIKit

class voteSurveyController: UIViewController {
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var reponseText0: UILabel!
    @IBOutlet weak var reponseText1: UILabel!
    @IBOutlet weak var reponseText2: UILabel!
    @IBOutlet weak var reponseText3: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
//    var radioButtonController = self.SSRadioButtonsController(buttons: button1, button2, button3)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let urlReceive = UserDefaults.standard.object(forKey: "survey") as? String {
            if let userId = UserDefaults.standard.object(forKey: "userId") as? Int {
                // Do any additional setup after loading the view, typically from a nib.
                let urlDefine = ("\(urlReceive)\(userId)")
                //                    GH48fg1 lien d'un sondage
                if let url = URL(string:urlDefine){
                    URLSession.shared.dataTask(with: url) {
                        (data, response, error) in
                        guard let data = data else {
                            return
                        }
                        do {
                            let root = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                            //print(root)
                            if let rootDict = root as? [String : Any] {
                                if let vote = rootDict["aVote"] as? Int {
                                    print("request response : \(vote)")
                                    if (vote == 1){
                                        print("l'utilisateur a déjà voté")
                                    }
                                }
                                
                                if let question = rootDict["question"] as? String {
                                    print("QUESTION : \(question)")
                                    self.questionText.text = question
                                }
                                
                                if let argument = rootDict["response"] as? [String : Any] {
                                    var count = 0
                                    for (key, value) in argument {
                                        if let listReponse = value as? [String : String] {
                                            if let reponse = listReponse["reponse"] {
                                                print(reponse)
                                                self.reponseText0.text = reponse
                                            }
                                            
                                            if let vote = listReponse["vote"] {
                                                print(vote)
                                            }
                                        }
                                        count = count + 1
                                    }
                                }
                                
                            }
                            
                        }
                        catch {
                            print("Le sondage n'existe pas")
                        }
                        
                        }.resume()
                    
                } else {
                    //            handle URL error
                }
                
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
