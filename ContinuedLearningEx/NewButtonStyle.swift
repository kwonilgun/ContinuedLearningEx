//
//  NewButtonStyle.swift
//  RGBullysEye
//
//  Created by kwonilgun on 2022/02/02.
//

import SwiftUI

struct NewButtonStyle: ButtonStyle{
    let width: CGFloat
    let height: CGFloat
 
    //‘Group is another SwiftUI container. It doesn’t do any layout. It’s just useful when you need to wrap code that’s more complicated than a single view.’
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .opacity(configuration.isPressed ? 0.2 : 1)
            .frame(width: width, height: height)
            .foregroundColor(Color(UIColor.systemBlue))
            .background(
                Group{
                    if configuration.isPressed {
                        Capsule()
                            .fill(Color.element)
                            .southEastShadow()
                    }
                    else {
                        Capsule()
                            .fill(Color.element)
                            .northWestShadow()
                    }
                }
            )
    }
    
    
}

