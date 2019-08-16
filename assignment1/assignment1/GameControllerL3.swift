//
//  GameControllerL3.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-19.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit

class GameControllerL3: UIViewController {

    @IBOutlet weak var submit: UIButton!
    
    @IBOutlet weak var answerInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClicksubmit(_ sender: UIButton) {
        let text: String? = answerInput.text
        
        switch text?.lowercased() {
        case "ottawa":
            alertSuccess()
        case "":
            alertEmpty()
        default:
            alertFail()
        }
        
    }
    
    func alertFail(){
        let alert = UIAlertController(title: "Sorry, Wrong Answer", message: "Please Try Again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func alertSuccess(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let GameControllerL3 = storyboard.instantiateViewController(withIdentifier: "LastController")
        present(GameControllerL3, animated: true, completion: nil)
    }
    
    func alertEmpty(){
        let alert = UIAlertController(title: "Please enter some valid value", message: "Please Try Again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
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
