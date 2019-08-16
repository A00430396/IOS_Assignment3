//
//  AlternateViewController.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-20.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit

class AlternateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var wonders:[Wonders] = []
    var dataToSave = Data()
//     let wondersOfTheWorld   = ["Great pyramid of Giza","Clossus of Rhodes","Hanging Gardens of Babylon", "Lighthouse of Alexandria", "Mausoleum at Halicarnassus", "Statue of Zeus at Olympia", "Temple of Artemis at Ephesu"]
    
    //     Local Storage
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("Wonders")
    
    struct AlternateCoordinates {
        var name: String
        var alternateName: String
        var alternateCoord: [Double]
    }
    
    let alternateCoordinates: [AlternateCoordinates] = [
        AlternateCoordinates(name: "Great Pyramid of Giza",alternateName: "Pyramid of Khaffre",alternateCoord: [31.1308, 29.9757]),
         AlternateCoordinates(name: "The Treasury, Petra, Jordan",alternateName: "The Garden Tomb",alternateCoord: [35.6803, 30.3840]),
         AlternateCoordinates(name: "Christ the Redeemer",alternateName: "parque lage", alternateCoord: [-43.2116, -22.9582]),
        AlternateCoordinates(name: "Chichen Itza",alternateName: "Somewhere close to Chichen Itza", alternateCoord: [-88.578703, 20.692838]),
        AlternateCoordinates(name: "Colosseum",alternateName: "Roman Forum",alternateCoord: [12.4853, 41.8925]),
        AlternateCoordinates(name: "China's Great Wall",alternateName: "Badaling Great Wall", alternateCoord: [116.00200, 40.3598]),
        AlternateCoordinates(name: "Machu Pichu",alternateName: "Somewhere close to Machu Pichu",alternateCoord: [-72.525821, -13.172849]),
        AlternateCoordinates(name: "Taj Mahal",alternateName: "Somewhere close to Taj Mahal",alternateCoord: [78.052086, 27.183006])
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        loadJsonFile()
        
    }
    
    
    @IBAction func onClickHome(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavedWondersSegue" {
            let savedWondersViewController = segue.destination as? SavedWondersViewController
            savedWondersViewController?.savedWonders = loadSavedData()
        }
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
        if wonders.count > 1 {
            saveToLocalStorage()
        }
    }

    func saveToLocalStorage() {
        do {
            dataToSave = try NSKeyedArchiver.archivedData(withRootObject: wonders, requiringSecureCoding: false)
            try dataToSave.write(to: AlternateViewController.ArchiveURL)
        } catch {
            print("Could not write")
        }
    }
    
    func loadSavedData() -> [Wonders] {
        var savedWonders: [Wonders] = []
        do {
            if let loadedStrings = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataToSave) as? [Wonders] {
                savedWonders = loadedStrings
            }
        } catch {
            print("Could not read")
        }
        return savedWonders
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

   
}
extension AlternateViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wonders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
            as? TableViewCell2 else { return UITableViewCell()}
        
        //cell.label.text = wondersOfTheWorld[indexPath.row]
        
        cell.label.text = wonders[indexPath.row].name
        //cell.icon.image = UIImage(data: data! as Data)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let controller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        controller?.name = wonders[indexPath.row].name
        controller?.desc = wonders[indexPath.row].wonderDescription ?? "Description not found!"
        controller?.imageURL = wonders[indexPath.row].imageURL
        controller?.coordinates = wonders[indexPath.row].coordinates
        for alternateCoordinate in alternateCoordinates {
            if(wonders[indexPath.row].name == alternateCoordinate.name){
                controller?.alternateName = alternateCoordinate.alternateName
                controller?.alternateCoordinates = alternateCoordinate.alternateCoord
            }
        }
        self.navigationController?.pushViewController(controller!, animated: true)

    }


    
}
