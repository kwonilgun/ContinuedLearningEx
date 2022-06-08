//
//  SoundBoot.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/07.
//

import SwiftUI
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    enum SomeSound: String{
        case bird
        case cinema
    }
    
    var player: AVAudioPlayer?
    
    
    
    func playsound(select: SomeSound) {
        
        guard let url = Bundle.main.url(forResource: select.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription )")
        }
    }
}


struct SoundBoot: View {
    var body: some View {
        
        VStack(spacing: 20) {
            Button(" Sound 1") {
                SoundManager.instance.playsound(select: .bird)
            }
            Button(" Sound 2") {
                SoundManager.instance.playsound(select: .cinema)
            }
        }
    }
}

struct SoundBoot_Previews: PreviewProvider {
    static var previews: some View {
        SoundBoot()
    }
}
