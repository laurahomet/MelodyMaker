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
    var model = MelodyModel()
    var delegate:HitProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        model.playMelody(melody: bestMelody)
    }
    
    //--- MARK: IBActions
    @IBAction func listenAgainTapped(_ sender: Any) {
        model.playMelody(melody: bestMelody)
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
    
}


//--- MARK: Segue To Final View Controller
extension HitViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let finalVC = segue.destination as! FinalViewController
        finalVC.bestMelody = self.bestMelody
        finalVC.modalPresentationStyle = .fullScreen
    }
    
}
