//
//  RotationGesture.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/03.
//

import SwiftUI



struct RotationGestureView: View {
    
    @State var angle: Angle = Angle(degrees: 0)
    
    var rotation: some Gesture {
       
            RotationGesture()
                .onChanged { angle in
                    self.angle = angle
                }
                .onEnded { value in
                    withAnimation(.spring()){
                        angle = Angle(degrees: 0)
                    }
                }
    }
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
                self.rotation
                
            )
    }
}

struct RotationGesture_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureView()
    }
}
