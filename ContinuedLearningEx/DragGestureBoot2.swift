//
//  DragGestureBoot2.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/03.
//

import SwiftUI

struct DragGestureBoot2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.87
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ Value in
                            withAnimation(.spring()){
                                
                                currentDragOffsetY = Value.translation.height
                            }

                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                    currentDragOffsetY = 0

                                } else if endingOffsetY != 0 && currentDragOffsetY > 150{
                                    endingOffsetY = 0
                                    currentDragOffsetY = 0
                                }
                                currentDragOffsetY = 0
                                
                            }
                        })
                
                )
            //Text("\(currentDragOffsetY)")
 
        }
    }
}

struct DragGestureBoot2_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBoot2()
    }
}

struct MySignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is the description for our app. This is my favorite SwiftUI cource and I recommend to all of my friends to subscribe to Swiftful thinking")
                .multilineTextAlignment(.center)
            Text("CREATE AN ACCOUNT")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
