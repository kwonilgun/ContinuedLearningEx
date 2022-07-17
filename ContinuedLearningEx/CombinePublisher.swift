//
//  CombinePublisher.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2022/07/04.
//

import SwiftUI
import Combine

let future1 = Future<Color, Never> { promise1 in
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            promise1(.success(Color.red))
          }
        }

let future2 = Future<Color, Never> { promise2 in
          DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            promise2(.success(Color.green))
          }
        }
let future3 = Future<Color, Never> { promise3 in
          DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            promise3(.success(Color.blue))
          }
        }
let future4 = Future<Color, Never> { promise4 in
          DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            promise4(.success(Color.orange))
          }
        }
struct CombinePublisher: View {
    
    @State var textColor = Color.black
    @State var clearRed = false
    @State var clearGreen = false
    @State var clearBlue = false
    @State var clearOrange = false
    
    var body: some View {
        Text("Hello World")
            .font(.largeTitle)
            .foregroundColor(Color.white)
            .padding()
            .background(textColor)
        if !clearRed {
            Color.clear
                .frame(width: 1, height: 1, alignment: .center)
                .onReceive(future1) { ( colour ) in
                    print("future1 \(colour)")
                    textColor = colour
                    clearRed = true
                }
        }
        if !clearGreen {
            Color.clear
                .frame(width: 1, height: 1, alignment: .center)
                .onReceive(future2) { ( colour ) in
                    print("future2 \(colour)")
                    textColor = colour
                    clearGreen = true
                }
        }
        if !clearBlue {
            Color.clear
                .frame(width: 1, height: 1, alignment: .center)
                .onReceive(future3) { ( colour ) in
                    print("future3 \(colour)")
                    textColor = colour
                    clearBlue = true
                }
        }
        if !clearOrange {
            Color.clear
                .frame(width: 1, height: 1, alignment: .center)
                .onReceive(future4) { ( colour ) in
                    print("future4 \(colour)")
                    textColor = colour
                    clearGreen = true
                }
        }
    }
    
}

struct CombinePublisher_Previews: PreviewProvider {
    static var previews: some View {
        CombinePublisher()
    }
}
