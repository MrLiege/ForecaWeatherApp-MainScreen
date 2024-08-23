//
//  SoundEffect.swift
//  AuthorizationAPI
//
//  Created by Artyom Petrichenko on 18.08.2024.
//

import Foundation
import AVFoundation

enum Sounds: String {
    case OpenEffect
    case CloseEffect
}

class SoundEffect {
    static let shared = SoundEffect()
    private var player: AVAudioPlayer?
    
    func playSound(_ sound: Sounds) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error with song: \(error.localizedDescription)")
        }
    }
}
