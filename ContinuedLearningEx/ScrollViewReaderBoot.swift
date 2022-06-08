//
//  ScrollViewReaderBoot.swift
//  ContinuedLearningEx
//
//  Created by kwonilgun on 2021/12/03.
//

import SwiftUI

struct ScrollViewReaderBoot: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""
    
    var body: some View {
        ScrollView {
            
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("CLICK HERE TO GO TO #49") {
                //withAnimation(.spring()) {
                    //proxy.scrollTo(30, anchor: .center)
                    if let index = Int(textFieldText){
                        scrollToIndex = index
                    }
                //}
                
            }
            
            ScrollViewReader { proxy in

                ForEach(0..<50) { index in
                    Text("This is item #\(index)")
                        .font(.headline)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow( radius: 10)
                        .padding()
                        .id(index)
                }
                .onChange(of: scrollToIndex) { value in
                    withAnimation(.spring()) {
                        proxy.scrollTo(value, anchor: .center)
                    }
                }
            }
            
        }
    }
}

struct ScrollViewReaderBoot_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBoot()
    }
}
