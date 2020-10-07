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
    
    //--- MARK: Status Flags
    enum Status {
        case initialization
        case evaluation
        case generation
    }
    
    //--- MARK: Melody Variables
    let model = GAModel()
    var melodies = [[String]]()
    var scores = [Float]()
    var soundPlayer = SoundManager()
    let numNotes = 8
    var melodyIndex = 0
    var status:Status = .initialization
    var bestMelody = [String]()
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
        
        print(status) //Must be in GA Model
        
        switch status {
        
            case .initialization:
                melodies = model.initialization(numNotes: numNotes)
                for _ in 1...melodies.count {
                    scores.append(0.0)
                }
                status = .evaluation
                
            case .evaluation:
                break
                
            case .generation:
                melodies = model.reproduction(numNotes: numNotes, melodies: melodies, scores: scores)
                for _ in 1...melodies.count {
                    scores.append(0.0)
                }
                status = .evaluation
        }
        
        //Play melody
        playMelody(melody: melodies[melodyIndex])
        
    }
    
    
    //--- MARK: IBActions
    @IBAction func listenAgainTapped(_ sender: Any) {
        
        playMelody(melody: melodies[melodyIndex]) //Will be in meoldy model
        
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
            
            status = .initialization //In case it´s the last loop
            performSegue(withIdentifier: "hitSegue", sender: self)
            
        } else {
            //Display a fade in or sth
            
            viewDidAppear(true)
            viewWillAppear(true) //Want this to happen before melody
        }
        
    }

    func playMelody(melody: [String]) {
        
        for note in melodies[melodyIndex] {
            soundPlayer.playSound(note: note)
        }
    }
    
}


//--- MARK: Segue To Hit View Controller
extension MakerViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let hitVC = segue.destination as! HitViewController
        hitVC.bestMelody = self.bestMelody
        hitVC.soundPlayer = self.soundPlayer
        hitVC.modalPresentationStyle = .fullScreen
        hitVC.delegate = self
    }
    
}

//--- MARK: Conform To Hit Protocol
extension MakerViewController: HitProtocol {
    
    func keepTraining() {
        status = .generation
        melodyIndex = 0
        
//        viewDidAppear(true)
//        viewWillAppear(true) //Want this to happen before melody
        
    }
    
    
}
