//
//  HitViewController.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 03/10/2020.
//

import UIKit

protocol HitProtocol {
    func keepTraining()
}

class HitViewController: UIViewController {
    
    //--- MARK: Variables
    var bestMelody = [String]()
    var soundPlayer = SoundManager()
    var delegate:HitProtocol?
    
    //--- MARK: VC Variables
//    var finalView:FinalViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        instantiateFinalView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Play melody
        playMelody(melody: bestMelody)
        
    }
    
    //--- MARK: IBActions
    @IBAction func listenAgainTapped(_ sender: Any) {
        
        playMelody(melody: bestMelody) //MelodyModel Protocol
        
    }
    
    @IBAction func keepTrainingTapped(_ sender: Any) {
        
        //Go back to Maker VC
        delegate?.keepTraining()
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        //Go to final VC
        performSegue(withIdentifier: "finalSegue", sender: self)
    }
    
    func playMelody(melody: [String]) { //In melody model later
        
        for note in melody {
            soundPlayer.playSound(note: note)
        }
    }
    
}



//--- MARK: Segue To Final View Controller
extension HitViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let finalVC = segue.destination as! FinalViewController
        finalVC.bestMelody = self.bestMelody
        finalVC.soundPlayer = self.soundPlayer
        finalVC.modalPresentationStyle = .fullScreen
    }
    
}
