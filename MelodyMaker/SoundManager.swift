//
//  SoundManager.swift
//  MelodyMaker
//
//  Created by Laura Homet Garcia on 03/10/2020.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer:AVAudioPlayer?
    
    func playSound(note: String) {
        
        let bundlePath = Bundle.main.path(forResource: note, ofType: ".wav")
        
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            usleep(200000)
        } catch {
            print("Couldn't create an audio player")
            return
        }
        
    }
    
}
