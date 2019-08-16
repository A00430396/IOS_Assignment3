//
//  GameControllerL2.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-19.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit

class GameControllerL2: UIViewController {

    @IBOutlet weak var option1: UIButton!
    
    @IBOutlet weak var option2: UIButton!
    
    @IBOutlet weak var option3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onClickOption1(_ sender: UIButton) {
        alertFail()
        
    }
    
    @IBAction func onClickOption2(_ sender: UIButton) {
        //alertSuccess()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let GameController = storyboard.instantiateViewController(withIdentifier: "GameControllerL3")
        present(GameController, animated: true, completion: nil)
    }
    
    @IBAction func onClickOption3(_ sender: UIButton) {
        alertFail()
    }
    
    func alertFail(){
        let alert = UIAlertController(title: "Sorry, You Lost", message: "Please Try Again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
//    func alertSuccess(){
//        let alert = UIAlertController(title: "You Won!", message: "Off to Level 3?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
