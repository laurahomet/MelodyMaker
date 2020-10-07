//
//  ViewController.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 02/10/2020.
//

import UIKit

class ViewController: UIViewController {

    //--- MARK: IBOutlets
    @IBOutlet weak var startButton: UIButton!
    
    //--- MARK: Variables
    var makerView:MakerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateMakerView()
    }
    
    //--- MARK: IBActions
    @IBAction func startTapped(_ sender: Any) {
        if makerView != nil {
            goToMakerView()
        }
    }
}

//--- MARK: Path To Maker View Controller
extension ViewController {
    
    func instantiateMakerView(){
        makerView = storyboard?.instantiateViewController(identifier: "MakerVC") as? MakerViewController
        makerView?.modalPresentationStyle = .fullScreen
    }
    
    func goToMakerView(){
        present(makerView!, animated: true, completion: nil)
    }
    
}


