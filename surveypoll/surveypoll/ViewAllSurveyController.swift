//
//  TableViewController.swift
//  Meteo
//
//  Created by Henintsoa Miora on 12/02/2018.
//  Copyright © 2018 Henintsoa Miora. All rights reserved.
//

import UIKit
import Foundation

class ViewAllSurveyController: UITableViewController {
    
    var allSurvey = AllSurvey()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userId = UserDefaults.standard.object(forKey: "userId") as? Int {
            if let url = URL(string:"https://www.teamoppai.fr/sondage/voirMesSondages.php?iduser=\(userId)"){
                URLSession.shared.dataTask(with: url) {
                    (data, response, error) in
                    guard let data = data else {
                        return
                    }
                    do {
                        let root = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        if let rootDict = root as? [Any] {
                            var nbrElement = 0
                            for element in rootDict {
                                let oneSurvey = Survey()
                                if var listSurvey = element as? [String : String] {
                                    if let question = listSurvey["question"] {
//                                        print(question)
                                        oneSurvey.question = question
                                    }
                                    
                                    if let url = listSurvey["url"] {
//                                        print(url)
                                        oneSurvey.url = url
                                    }
                                    print(oneSurvey)
                                    self.allSurvey.survey = [oneSurvey]
                                    
                                }
                                
//                                self.allSurvey = survey
                                nbrElement = nbrElement + 1
                            }
                            
                        }
                        for element in self.allSurvey.survey {
                            print(element)
                        }
                    }
                    catch {
                        
                    }
                    
                    }.resume()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellule", for: indexPath)
        let text = "test"
        //self.allSurvey.survey[indexPath.row].question
        cell.textLabel?.text = text
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


