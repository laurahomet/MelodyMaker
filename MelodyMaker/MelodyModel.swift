//
//  MelodyModel.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 02/10/2020.
//

import Foundation

class MelodyModel {
    
    let model = NotesModel()
    let melody = [String]()
    
    func getMelody(numNotes: Int) -> [String] {
        
        var generatedNotes = [String]()
            
        for _ in 1...numNotes {
            generatedNotes.append(model.getNote())
        }
            
        return generatedNotes
    }

    
}
