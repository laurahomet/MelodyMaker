//
//  FinalViewController.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 03/10/2020.
//

import UIKit

class FinalViewController: UIViewController {
    
    //--- MARK: VC Variables
    var mainView:ViewController?
    
    //--- MARK: Variables
    var bestMelody = [String]()
    var soundPlayer = SoundManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instantiateMainView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        var i=0
        while(i < 8) {
            playMelody(melody: bestMelody) //Melody model protocol?
            i += 1
        }
        
    }
    
    func playMelody(melody: [String]) { //In melody model later
        
        for note in melody {
            soundPlayer.playSound(note: note)
        }
    }
    
    
    //---MARK: IBActions
    @IBAction func backToStartTapped(_ sender: Any) {
        //Go to VC
        if mainView != nil {
            goToMainView()
        }
    }

}

extension FinalViewController {
    
    func instantiateMainView(){
        mainView = storyboard?.instantiateViewController(identifier: "MainVC") as? ViewController
        mainView?.modalPresentationStyle = .fullScreen
    }
    
    func goToMainView(){
        present(mainView!, animated: true, completion: nil)
    }
    
}
