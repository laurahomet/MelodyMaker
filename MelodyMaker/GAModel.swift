//
//  GAModel.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 02/10/2020.
//

import Foundation

class GAModel {
    
    enum Status {
        case initialization
        case evaluation
        case generation
    }
    
    let melodyModel = MelodyModel()
    let noteModel = NotesModel()
    var status:Status = .initialization
    
    func initialization(numNotes: Int) -> [[String]]{
        
        var generatedMelodies = [[String]]()
        
        for _ in 0...2 {
            generatedMelodies.append(melodyModel.getMelody(numNotes: numNotes))
        }
        
        return generatedMelodies
        
    }
    
    func reproduction(numNotes: Int, melodies: [[String]], scores: [Float]) -> [[String]]{
        
        var newMelodies = [[String]]()
        
        let wheel = createWheel(scores: scores)
        
        for _ in 0...melodies.count-1 {
            
            let parents         = pickParents(melodies: melodies, scores: scores, wheel: wheel)
            let crossMelody     = crossover(parents: parents, numNotes: numNotes)
            let mutatedMelody   = mutation(melody: crossMelody, numNotes: numNotes, note: noteModel.getNote())
            
            //Add to new population
            newMelodies.append(mutatedMelody)
        }
        
        return newMelodies
    }
    
    
    func createWheel(scores: [Float]) -> [Float] {
        
        let sum = scores.reduce(0.0,+)
        var percent = [Float]()
        var cum_percent:Float = 0

        for i in 0...scores.count-1 {
            percent.append(Float(scores[i])/Float(sum) + cum_percent)
            cum_percent += Float(scores[i])/Float(sum)
        }
        
        return percent
        
    }
    
    
    func pickParents(melodies: [[String]], scores: [Float], wheel: [Float]) -> [[String]] {
        
        var parentMelodies = [melodies[0],melodies[1]]
        
        for j in 0...1 {
            let random:Float = Float.random(in: 0...1)
            
            var done:Bool = false
            for i in 0...scores.count-1 {
                if !done && wheel[i] > random {
                    parentMelodies[j] = melodies[i]
                    done = true
                }
            }
        }
        
        return parentMelodies
    }
    
    
    func crossover(parents: [[String]], numNotes: Int) -> [String] {
        
        var melody = parents[0] //Initialize it as the first parent
        let randomPosition = Int.random(in: 0...numNotes-1) //Version 2.0. Improved: Variable position for insertion of 'parent' notes
        
        for i in 0...numNotes-1 {
            if(i < randomPosition) {
                melody[i] = parents[0][i]
            }
            else {
                melody[i] = parents[1][i]
            }
        }
        
        return melody
        
    }
    
    
    func mutation(melody: [String], numNotes: Int, note: String) -> [String] {
        
        var newMelody = melody
        
        for _ in 1...numNotes/4 {
            let randomNote = Int.random(in: 0...numNotes-1)
            newMelody[randomNote] = note
        }
        
        return newMelody
        
    }
    
}
