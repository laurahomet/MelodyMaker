//
//  NotesModel.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 02/10/2020.
//

import Foundation

class NotesModel {
    
    let notesDict = [1: "C",
                     2: "D",
                     3: "E",
                     4: "F",
                     5: "G",
                     6: "A",
                     7: "B",
                     8: "Silent"]
    
    func getNote() -> String {
        return notesDict[Int.random(in: 1...8)]!
    }
    
}
