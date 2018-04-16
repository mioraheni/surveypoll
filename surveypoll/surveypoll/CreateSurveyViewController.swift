//
//  CreateSurveyViewController.swift
//  surveypoll
//
//  Created by Henintsoa Miora on 16/04/2018.
//  Copyright © 2018 Hauret Xiong. All rights reserved.
//

import UIKit

class CreateSurveyViewController: UIViewController {

    @IBOutlet weak var createQuestion: UITextField!
    @IBOutlet weak var response1: UITextField!
    @IBOutlet weak var response2: UITextField!
    @IBOutlet weak var response3: UITextField!
    @IBOutlet weak var response0: UITextField!
    @IBOutlet weak var multipleR: UISwitch!
    @IBOutlet weak var error: UILabel!
    @IBOutlet weak var errorR: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool
    {
        if (identifier == "createSurvey"){
            if let userId = UserDefaults.standard.object(forKey: "userId") as? Int {
                if let createQuestion = createQuestion.text{
                    if(createQuestion != ""){
                        let replace = "%20"
                        var createQuestion = createQuestion.replacingOccurrences(of: " ", with: replace, options: .literal, range: nil)
                        var nbrReponse = 0
                        var reponse1 = ""
                        var reponse2 = ""
                        var reponse3 = ""
                        var reponse0 = ""
                        error.text = ""
                        errorR.text = ""
                        var reponseMulti = 0
                        if var response0 = response0.text as? String{
                            if response0 != "" {
                                nbrReponse = nbrReponse + 1
                                response0 = response0.replacingOccurrences(of: " ", with: replace, options: .literal, range: nil)
                                reponse0 = "&reponse0=\(response0)"
                            }else{
                                errorR.text = "Vous devez au moins avoir une réponse"
                            }
                        }
                        if var response1 = response1.text as? String{
                            if response1 != "" {
                                nbrReponse = nbrReponse + 1
                                response1 = response1.replacingOccurrences(of: " ", with: replace, options: .literal, range: nil)
                                reponse1 = "&reponse1=\(response1)"
                            }
                        }
                        if var response2 = response2.text as? String{
                            if response2 != "" {
                                nbrReponse = nbrReponse + 1
                                response2 = response2.replacingOccurrences(of: " ", with: replace, options: .literal, range: nil)
                                reponse2 = "&reponse2=\(response2)"
                            }
                        }
                        if var response3  = response3.text as? String{
                            if response3 != "" {
                                nbrReponse = nbrReponse + 1
                                response3 = response3.replacingOccurrences(of: " ", with: replace, options: .literal, range: nil)
                                reponse3 = "&reponse3=\(response3)"
                            }
                        }
                        if(multipleR.isOn){
                            reponseMulti = 1
                        }
                        
                        let nombre = "&nbrR=\(nbrReponse)"
                        let urlDefine = "https://www.teamoppai.fr/sondage/createSondage.php?iduser=\(userId)&question=\(createQuestion)\(reponse0)\(reponse1)\(reponse2)\(reponse3)\(nombre)&multipleR=\(reponseMulti)"
                        print(urlDefine)
                        if let url = URL(string:urlDefine){
                            URLSession.shared.dataTask(with: url) {
                                (data, response, error) in
                                guard let data = data else {
                                    return
                                }
                                do {
                                    let root = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                    if let rootDict = root as? [String : Any] {
                                        
                                        if let url = rootDict["url"] as? String {
                                            print("url : \(url)")
                                            UserDefaults.standard.set(url, forKey:"survey");
                                            UserDefaults.standard.synchronize();
                                        }
//                                        return true
                                    }
                                    
                                }
                                catch {
                                    print("Le sondage n'existe pas")
                                }
                                
                            }.resume()
                        } else {
                            //            handle URL error
                        }
                    }else{
                        error.text = "Vous devez au moins écrire une question"
                    }
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
