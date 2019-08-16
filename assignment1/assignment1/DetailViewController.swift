//
//  DetailViewController.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-26.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var placeDesc: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var name = ""
    var desc = ""
    var imageURL = ""
    var coordinates: [Double] = []
    var alternateCoordinates: [Double] = []
    var alternateName = ""
    //var wonder: Wonders?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = name
        placeDesc.text = desc
        downloaded(from: URL(string: imageURL)!)
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tappedMe))
        image.addGestureRecognizer(tap)
        image.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MapSegue" {
            let mapViewController = segue.destination as? MapViewController
            mapViewController?.wonderLocation = CLLocation(latitude:coordinates[1], longitude: coordinates[0])
            mapViewController?.alternateLocation = CLLocation(latitude:alternateCoordinates[1], longitude: alternateCoordinates[0])
            mapViewController?.wonderName = name
            mapViewController?.alternateName = alternateName
        }
    }
    
    @objc func tappedMe()
    {
        showAlert()
    }
    
    func showAlert() {
        let copyURL = UIAlertAction(title: "Copy Img URL", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            UIPasteboard.general.string = self.imageURL
        }
        let alert = UIAlertController(title: "Info", message: "The Image URL is available for download.", preferredStyle: .alert)
        alert.addAction(copyURL)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func ShowMap(_ sender: Any){
        
    }
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        self.spinner(shouldSpin: true)
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image1 = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image.image = image1
                self.spinner(shouldSpin: false)
            }
            }.resume()
    }
    
    func spinner(shouldSpin status: Bool){
        if(status == true){
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
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
