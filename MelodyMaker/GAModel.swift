//
//  GAModel.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 02/10/2020.
//

import Foundation

class GAModel {
    
    let model = MelodyModel()
    let noteModel = NotesModel()
    
    func initialization(numNotes: Int) -> [[String]]{
        
        var generatedMelodies = [[String]]()
        
        for _ in 0...4 {
            generatedMelodies.append(model.getMelody(numNotes: numNotes))
        }
        
        return generatedMelodies
        
    }
    
    func reproduction(numNotes: Int, melodies: [[String]], scores: [Float]) -> [[String]]{
        
        var newMelodies = [[String]]()
        
        //Create wheel from the scores
        let sum = scores.reduce(0.0,+)
        var percent = [Float]()
        var cum_percent:Float = 0

        for i in 0...scores.count-1 {
            percent.append(Float(scores[i])/Float(sum) + cum_percent)
            cum_percent += Float(scores[i])/Float(sum)
        }
        
        
        for _ in 0...melodies.count-1 {
            
            //Pick two parents
            var parentMelodies = [melodies[0],melodies[1]]
            
            for j in 0...1 {
                let random:Float = Float.random(in: 0...1)
                
                var done:Bool = false
                for i in 0...scores.count-1 {
                    if !done && percent[i] > random {
                        parentMelodies[j] = melodies[i]
                        done = true
                    }
                }
            }
        
            //Crossover
            var melody = parentMelodies[0] //Initialize it as the first parent
            let randomPosition = Int.random(in: 0...numNotes-1)
            
            for i in 0...numNotes-1 {
                if(i < randomPosition) {
                    melody[i] = parentMelodies[0][i]
                }
                else {
                    melody[i] = parentMelodies[1][i]
                }
            }
        
            //Mutation
            
            for _ in 1...numNotes/4 {
                let randomNote = Int.random(in: 0...numNotes-1)
                melody[randomNote] = noteModel.getNote()
            }
            
            //Add to new population
            newMelodies.append(melody)
        
        } //End for loop
        
        return newMelodies
    }
    
    
    func createWheel() {
        
    }
    
    func pickParents() {
        
    }
    
    func crossover() {
        
    }
    
    
    func mutation() {
        
    }
    
}
