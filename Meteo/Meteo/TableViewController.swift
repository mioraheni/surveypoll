//
//  TableViewController.swift
//  Meteo
//
//  Created by Henintsoa Miora on 12/02/2018.
//  Copyright © 2018 Henintsoa Miora. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var meteo = MeteoDB()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 0.3529, green: 0.7608, blue: 0.8471, alpha: 1.0)
        
        // Do any additional setup after loading the view, typically from a nib.
        print("ok")
        if let url = URL(string:"http://www.infoclimat.fr/public-api/gfs/json?_ll=48.85341,2.3488&_auth=BhwDFFMtUXMDLlNkBXNWfwBoV2IIfgYhBHhRMgxpUC1UP1IzAmIBZwVrVyoEKwYwVnsObQoxBzcBalcvD31TMgZsA29TOFE2A2xTNgUqVn0ALlc2CCgGIQRuUTcMf1AyVD5SPwJ%2FAWUFdFc3BDAGN1Z6DnEKNAc6AWNXOA9mUzIGZANvUzlRMwNzUy4FMFYzADtXNggzBjkEb1E0DGJQOlRhUmcCZgFrBXRXMgQ2BjBWZw5uCjYHOgFlVy8PfVNJBhYDelNwUXEDOVN3BShWNwBtV2M%3D&_c=523b747bf7863882ccf258ea993082c9"){
            URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                guard let data = data else {
                    return
                }
                do {
                    
                    let root = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let rootDict = root as? [String : Any] {
                        if let request = rootDict["request_state"] as? Int {
                            print("request response : \(request)")
                        }
                        //                      for entry in root
                        
                        
                        for (key, value) in rootDict {
                            let format = DateFormatter()
                            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
                            if let date = format.date(from: key){
                                //                                print("date : \(date)")
                                
                                
                                if let prediction  = value as? [String : Any]
                                {
                                    if let temps = prediction["temperature"] as? [String: Double]
                                    {
                                        if var temperature = temps["sol"]
                                        {
                                            let Predic = Prediction()
                                            temperature = temperature - 273.15
                                            //                                          Ajout au dictionnaire
                                            Predic.temp = temperature
                                            //                                            Predic.sorted { $0.date < $1.date}
                                            if let neige = prediction["risque_neige"] as? String{
                                                print("la neige : \(neige)")
                                                Predic.risqueNeige = neige
                                            }
                                            print("Temperature le \(date) = \(Predic.temp)°C")
                                            //meteo.outPut[date]
                                            self.meteo.rawDatas[date] = Predic
                                            //                                            self.meteo.rawDatas.append(Predic)
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        self.meteo.compute()
                        for element in self.meteo.outPut {
                            print("\(element.key): \(String(format : "%.2f", element.value.temp))°C")
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                }
                catch {
                    
                }
                
                }.resume()
            
        } else {
            //            handle URL error
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
        // #warning Incomplete implementation, return the number of rows
        return meteo.outPut.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellule", for: indexPath)
        let date = self.meteo.outPut[indexPath.row].key
        let degre = self.meteo.outPut[indexPath.row].value.temp
        
        // Configure the cell...
        var journee = ""
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        let hour = calendar.component(.hour, from: date)
        if(hour < 12){
            journee = "matin"
            cell.backgroundColor = UIColor.blue
        }else{
            journee = "apres midi"
            cell.backgroundColor = UIColor.clear
        }
        
        let laTemp = "\(day)/\(month)/\(year) [\(journee)]: \(String(format : "%.2f", self.meteo.outPut[indexPath.row].value.temp))°C"
        cell.textLabel?.text = laTemp
        
        
        
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
