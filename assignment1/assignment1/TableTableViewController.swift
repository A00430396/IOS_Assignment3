//
//  TableTableViewController.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-20.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit

class TableTableViewController: UITableViewController {

    var wondersOfTheWorld: [String] = []
    
    var imageNames:[String] = []
    var wonders:[Wonders] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wondersOfTheWorld   = ["Great pyramid of Giza","Clossus of Rhodes","Hanging Gardens of Babylon", "Lighthouse of Alexandria", "Mausoleum at Halicarnassus", "Statue of Zeus at Olympia", "Temple of Artemis at Ephesu"]
        imageNames = ["pyramid","statue","flower","LIGHTHOUSE","tomb","statue","temple"]
        loadJsonFile()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func loadJsonFile() {
        guard let jsonFile = Bundle.main.path(forResource: "wonders", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile))
        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String: Any],
            let wondersDictionary = dictionary["features"] as? [[String: Any]]
            else { return }
        let validWonders = wondersDictionary.compactMap { Wonders(wonder: $0) }
        wonders.append(contentsOf: validWonders)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return wondersOfTheWorld.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            as? TableViewCellController else { return UITableViewCell()}
//        if indexPath.item % 2 == 0{
//            cell.backgroundColor = UIColor.gray
//        }else{
//            cell.backgroundColor = UIColor.darkGray
//        }
        //cell.label.text = wondersOfTheWorld[indexPath.row]
        
        cell.label.text = wonders[indexPath.row].name
        cell.icon.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }
    
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
