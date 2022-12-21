//
//  SoundManager.swift
//  ReactionRate
//
//  Created by 1 on 21.12.2022.
//

import Foundation
import AVFoundation

class MusicManager {
    
    private init() {}
    
    static var shared = MusicManager()
    
    private func playSound(withId id: Int) {
        AudioServicesPlaySystemSoundWithCompletion(SystemSoundID(id)) {}
    }
    
    func playStart() {
        self.playSound(withId: 1013)
    }
    
    func playWin() {
        self.playSound(withId: 1025)
    }
    
    func playTick() {
        self.playSound(withId: 1103)
    }
    
    func playOver() {
        self.playSound(withId: 1034)
    }
    
    func playTock() {
        self.playSound(withId: 1104)
    }
    
    func playVggooh() {
        self.playSound(withId: 1001)
    }
    
    private var bombSoundEffect: AVAudioPlayer?
    
    func playWoow() {
        let path = Bundle.main.path(forResource: "wooow.wav", ofType: nil)!
        let url = URL(fileURLWithPath: path)

        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
}
