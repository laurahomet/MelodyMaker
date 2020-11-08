//
//  MakerViewController.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 03/10/2020.
//

import UIKit

class MakerViewController: UIViewController {
    
    //--- MARK: IBOutlets
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var listenAgainButton: UIButton!
    
    //--- MARK: Melody Variables
    let numNotes = 8
    var melodyModel = MelodyModel()
    var melodies = [[String]]()
    var bestMelody = [String]()
    var melodyIndex = 0
    
    //--- MARK: Genetic Algorithm Variables
    let gaModel = GAModel()
    var scores = [Float]()
    
    //--- MARK: VC Variables
    var hitView:HitViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.layer.cornerRadius = 20
        slider.isContinuous = false
        
        hitView?.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        slider.value = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        switch gaModel.status {
        
            case .initialization:
                melodies = gaModel.initialization(numNotes: numNotes)
                for _ in 1...melodies.count {
                    scores.append(0.0)
                }
                gaModel.status = .evaluation
                
            case .evaluation:
                break
                
            case .generation:
                melodies = gaModel.reproduction(numNotes: numNotes, melodies: melodies, scores: scores)
                for m in 0...melodies.count-1 {
                    scores[m] = 0.0
                }
                gaModel.status = .evaluation
        }
        
        melodyModel.playMelody(melody: melodies[melodyIndex])
        
    }
    
    
    //--- MARK: IBActions
    @IBAction func listenAgainTapped(_ sender: Any) {
        
        melodyModel.playMelody(melody: melodies[melodyIndex])
    }
    
    @IBAction func sliderChanged(_ sender: Any) {
        scores[melodyIndex] = slider.value
    }
    

    @IBAction func nextTapped(_ sender: Any) {
        
        melodyIndex += 1
        
        if melodyIndex == melodies.count {
            
            for i in 0...melodies.count-1 {
                if(scores[i] == scores.max()) {
                    bestMelody = melodies[i]
                }
            }
            
            gaModel.status = .initialization //In case it´s the last loop
            performSegue(withIdentifier: "hitSegue", sender: self)
            
        } else {
            //Display a fade in or sth
            
            viewDidAppear(true)
            viewWillAppear(true) //Want this to happen before melody
        }
        
    }
    
}


//--- MARK: Segue To Hit View Controller
extension MakerViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let hitVC = segue.destination as! HitViewController
        hitVC.bestMelody = self.bestMelody
        hitVC.modalPresentationStyle = .fullScreen
        hitVC.delegate = self
    }
    
}

//--- MARK: Conform To Hit Protocol
extension MakerViewController: HitProtocol {
    
    func keepTraining() {
        gaModel.status = .generation
        melodyIndex = 0
        
//        viewDidAppear(true)
//        viewWillAppear(true) //Want this to happen before melody
        
    }
    
    
}
