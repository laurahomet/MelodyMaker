//
//  MelodyModel.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 02/10/2020.
//

import Foundation

class MelodyModel {
    
    let model = NotesModel()
    var soundPlayer = SoundManager()
    
    func getMelody(numNotes: Int) -> [String] {
        
        var generatedNotes = [String]()
            
        for _ in 1...numNotes {
            generatedNotes.append(model.getNote())
        }
            
        return generatedNotes
    }

    func playMelody(melody: [String]) {
        
        for note in melody {
            soundPlayer.playSound(note: note)
        }
    }
    
}
