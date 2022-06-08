//
//  HapticBootEx.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/07.
//

import SwiftUI

class HapticManager {
    
    static var instance = HapticManager()  //Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
}

struct HapticBootEx: View {
    var body: some View {
        VStack(spacing: 20){
            Button("Success") { HapticManager.instance.notification(type: .success) }
            Button("waring") { HapticManager.instance.notification(type: .warning) }
            Button("error") { HapticManager.instance.notification(type: .error)}
            Divider()
                Button("soft") {HapticManager.instance.impact(style: .soft)}
                Button("light") {HapticManager.instance.impact(style: .light)}
                Button("medium") {HapticManager.instance.impact(style: .medium)}
                Button("rigid") {HapticManager.instance.impact(style: .rigid)}
                Button("heavy") {HapticManager.instance.impact(style: .heavy)}
                
            }
        }
}


struct HapticBootEx_Previews: PreviewProvider {
    static var previews: some View {
        HapticBootEx()
    }
}
