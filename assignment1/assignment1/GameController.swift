//
//  GameController.swift
//  assignment1
//
//  Created by Talwinder saini on 2019-07-19.
//  Copyright © 2019 nishant_talwinder. All rights reserved.
//

import UIKit

class GameController: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var gameSlider: UISlider!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onClickSubmit(_ sender: UIButton) {
        let range = 90...110
        switch Int(gameSlider.value){
        case range:
            //showAlertSuccess()
            navigateToLevel2()
        default:
            showAlertFail()
        }
    }
    
    func navigateToLevel2(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let GameController = storyboard.instantiateViewController(withIdentifier: "GameControllerL2")
        present(GameController, animated: true, completion: nil)
    }
    
    func showAlertFail()
    {
        let alert = UIAlertController(title: "Wrong! Try moving close to center", message: "Please try again!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
//    func showAlertSuccess(){
//        let alert = UIAlertController(title: "Wow ! You won!", message: "Lets see if you can win again!", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
//  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
